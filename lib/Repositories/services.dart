import 'package:flutter/foundation.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../Model/movie_model.dart';
import '../Utils/constants.dart';
import 'data.dart';

final tmdbWithCustomLogs = TMDB(
  ApiKeys(apiKey, readAccessToken),
  logConfig: const ConfigLogger(
    showLogs: true,
    showErrorLogs: true,
  ),
);

Future<List<MovieModel>> getData() async {
  try{
    final response = await tmdbWithCustomLogs.v3.movies.getTopRated();
  List<MovieModel> list = [];
  for (var value in response['results']) {
    if (favoriteMovies.any((element) => element.id == value['id'] as int)) {
      list.add(MovieModel.fromMap(value).copyWith(isChecked: true));
    } else {
      list.add(MovieModel.fromMap(value));
    }
  }
  final movies = list;
  return movies;
  }catch(e){
    if (kDebugMode) {
      print(e);
    }
  }
  return [];
}

Future<List<MovieModel>> getSingleData(String movieName) async {
  try {
    final response = await tmdbWithCustomLogs.v3.search.queryMovies(movieName);
    List<MovieModel> list = [];
    for (var value in response['results']) {
      if (favoriteMovies.any((element) => element.id == value['id'] as int)) {
        list.add(MovieModel.fromMap(value).copyWith(isChecked: true));
      } else {
        list.add(MovieModel.fromMap(value));
      }
    }
    final searchMovie = list;
    return searchMovie;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return [];
  }
}
