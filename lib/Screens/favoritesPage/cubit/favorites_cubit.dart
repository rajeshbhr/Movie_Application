import 'package:bloc/bloc.dart';


import '../../../Model/movie_model.dart';
import '../../../Repositories/data.dart';
import '../../../Repositories/localDB.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial(movies: favoriteMovies));
  void addMovie(MovieModel movieModel, int index) async{
    emit(
      FavoritesLoaState(),
    );
    if (!favoriteMovies.contains(movieModel)){
      favoriteMovies.add(movieModel);
      await LocalDB.createItem(movieModel);
      fetchMovies.removeAt(index);
      fetchMovies.insert(index, movieModel.copyWith(isChecked: true));
    }
    emit(FavoritesInitial(movies: favoriteMovies));

  }

  void removeMovie(MovieModel movie, int index)async {
    emit(
      FavoritesLoaState(),
    );
    await LocalDB.deleteItem(movie.id!);
    favoriteMovies.removeWhere((element) => element.id == movie.id);
    fetchMovies.removeAt(index);
      fetchMovies.insert(index, movie.copyWith(isChecked: false));
    emit(FavoritesInitial(movies: favoriteMovies));
  }
}
