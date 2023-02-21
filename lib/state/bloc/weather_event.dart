part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class InitialzeApp extends WeatherEvent {
  const InitialzeApp();
  @override
  List<Object> get props => [];
}

class GetDefaultData extends WeatherEvent {
  final List<int> favList;

  const GetDefaultData(this.favList);
  @override
  List<Object> get props => [favList];
}

class InternetDisconnected extends WeatherEvent {
  const InternetDisconnected();
  @override
  List<Object> get props => [];
}

class InternetConnected extends WeatherEvent {
  const InternetConnected();
  @override
  List<Object> get props => [];
}
