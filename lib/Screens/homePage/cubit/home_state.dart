part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLodingState extends HomeState {}

// ignore: must_be_immutable
class HomeLodedState extends HomeState {
 
  List<MovieModel> movies;
   
  @override
  List<Object> get props => [movies];
  HomeLodedState({required this.movies});
}


