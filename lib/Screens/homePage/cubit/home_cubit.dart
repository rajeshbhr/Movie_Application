import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../Model/movie_model.dart';
import '../../../Repositories/data.dart';
import '../../../Repositories/localDB.dart';
import '../../../Repositories/services.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    getDataFromDb();
    getPopular();
  }

  Future<void> getPopular() async {
    emit(HomeLodingState());
    fetchMovies = await getData();

    emit(
      HomeLodedState(movies: fetchMovies),
    );
  }

  Future<void> getDataFromDb() async {
    final response = await LocalDB.getItems();
    for (var value in response) {
      if (!favoriteMovies.any((element) => element.id == value['id'])) {
        favoriteMovies.add(MovieModel.fromMap(value).copyWith(isChecked: true));
      }
    }
  }

  void addMovie(MovieModel movieModel, int index) async {
    emit(HomeLodingState());
    if (!favoriteMovies.any((element) => element.id == movieModel.id)) {
      favoriteMovies.add(movieModel.copyWith(isChecked: true));
      await LocalDB.createItem(movieModel);
      fetchMovies.removeAt(index);
      fetchMovies.insert(index, movieModel.copyWith(isChecked: true));
    }
    emit(
      HomeLodedState(movies: fetchMovies),
    );
  }

  void removeMovie(MovieModel movie, int index) async {
    emit(HomeLodingState());
    favoriteMovies.removeWhere((element) => element.id == movie.id);
    await LocalDB.deleteItem(movie.id ?? -1);
    fetchMovies.removeAt(index);
    fetchMovies.insert(index, movie.copyWith(isChecked: false));
    emit(
      HomeLodedState(movies: fetchMovies),
    );
  }

  void sortByRating() {
    emit(HomeLodingState());
    fetchMovies.sort((a, b) => a.voteAverage!.compareTo(b.voteAverage!));
    fetchMovies = fetchMovies.reversed.toList();
    emit(HomeLodedState(movies: fetchMovies));
  }

  void sortByPopularity() {
    emit(HomeLodingState());
    fetchMovies.sort((a, b) => a.popularity!.compareTo(b.popularity!));
    fetchMovies = fetchMovies.reversed.toList();
    emit(HomeLodedState(movies: fetchMovies));
  }

  void sortByYear() {
    emit(HomeLodingState());
    fetchMovies.sort((a, b) => a.releaseDate!.compareTo(b.releaseDate!));
    fetchMovies = fetchMovies.reversed.toList();
    emit(HomeLodedState(movies: fetchMovies));
  }

  void update() {
    emit(HomeLodingState());
    emit(HomeLodedState(movies: fetchMovies));
  }
}
