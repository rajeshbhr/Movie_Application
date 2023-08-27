// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_cubit.dart';


abstract class FavoritesState {}

// ignore: must_be_immutable
class FavoritesInitial extends FavoritesState {
  List<MovieModel> movies;
  FavoritesInitial({
    required this.movies,
  });
}

class FavoritesLoaState extends FavoritesState {

}


