part of 'search_cubit.dart';


abstract class SearchState extends Equatable{}

class SearchInitial extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchLodingState extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class SearchLodedState extends SearchState {
  List<MovieModel> movies;
  SearchLodedState({required this.movies});
  
  @override
  // TODO: implement props
  List<Object?> get props => [movies];
}