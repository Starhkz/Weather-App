import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_app/core/services/api/api_service.dart';
import 'package:weather_app/core/services/storage.dart';
import 'package:weather_app/features/model/city.dart';
import 'package:weather_app/features/model/weather.dart';

class FavouritesCubit extends Cubit<List<int>> {
  final SharedPreferenceLocalStorage prefs;

  FavouritesCubit(super.initialState, this.prefs);

  void remove(int index) {
    state.remove(index);
    emit(state);
    prefs.setIntList(state);
  }

  void add(int index) {
    state.add(index);
    emit(state);

    prefs.setIntList(state);
  }

  bool isFavourite(index) {
    return state.contains(index);
  }
}

class FavouritesQueryCubit extends Cubit<List<City>> {
  FavouritesQueryCubit(super.initialState);
  void refresh() {
    emit(cities);
  }

  void query(String query) {
    if (query.isEmpty || query == '') {
      emit(cities);
    }
    var result = cities
        .where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(result);
  }
}

class MainCardCubit extends Cubit<WeatherModel> {
  MainCardCubit(super.initialState);
  void setDataFromSearch(City city) async {
    var json = await ApiService().getWeatherFromCity(city.name);
    WeatherModel weatherModel = WeatherModel.fromJSON(json);
    emit(weatherModel);
  }

  Future<void> setDataFromLocation() async {
    Location location = Location();
    LocationData currentLocation = await location.getLocation();
    var json = await ApiService().getWeatherFromLocation(currentLocation);
    WeatherModel weatherModel = WeatherModel.fromJSON(json);
    emit(weatherModel);
  }
}

Future<List<WeatherModel>> getWeatherData(List<int> favIndices) async {
  List<WeatherModel> models = [];
  for (int index in favIndices) {
    City city = cities[index];
    var json = await ApiService().getWeatherFromCity(city.name);
    WeatherModel weatherModel = WeatherModel.fromJSON(json);
    models.add(weatherModel);
  }
  return models;
}
