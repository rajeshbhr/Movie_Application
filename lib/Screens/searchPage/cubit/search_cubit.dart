import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../Model/movie_model.dart';
import '../../../Repositories/data.dart';
import '../../../Repositories/localDB.dart';
import '../../../Repositories/services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  Future<void> getSearchMovie(String value)async{
    emit(SearchLodingState());
    searchMovies = await getSingleData(value).timeout(const Duration(seconds: 5));
    emit(SearchLodedState(movies: searchMovies),);
  }

  void addMovie(MovieModel movieModel, int index) async{
    emit(SearchLodingState());
    print('search');
    if (!favoriteMovies.any((element) =>element.id == movieModel.id)) {
      favoriteMovies.add(movieModel.copyWith(isChecked: true));
      await LocalDB.createItem(movieModel);
      searchMovies.removeAt(index);
      searchMovies.insert(index, movieModel.copyWith(isChecked: true));
    }
    emit(
      SearchLodedState(movies: searchMovies),
    );
  }

  void removeMovie(MovieModel movie, int index)async {
    emit(SearchLodingState());
    favoriteMovies.removeWhere((element) => element.id == movie.id);
    await LocalDB.deleteItem(movie.id??-1);
    searchMovies.removeAt(index);
      searchMovies.insert(index, movie.copyWith(isChecked: false));
    emit(
      SearchLodedState(movies: searchMovies),
    );
  }
}
