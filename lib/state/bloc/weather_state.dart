part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class NoInternet extends WeatherState {
  @override
  List<Object> get props => [];
}

class InternetRestored extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final List<WeatherModel> data;
  WeatherLoaded({required this.data});

  @override
  List<Object> get props => [data];
}
