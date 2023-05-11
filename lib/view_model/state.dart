import 'package:flutter/foundation.dart';
import 'package:ny_times/model/most_popular_model.dart';

@immutable
abstract class HomeState {}

class InitialState extends HomeState {}

class InitialLoadingState extends HomeState {}

class LoadedState extends HomeState {
  final MostPopularModel mostPopularModel;

  LoadedState({required this.mostPopularModel});
}

class ErrorState extends HomeState {
  final String message;
  ErrorState({
    required this.message,
  });
}
