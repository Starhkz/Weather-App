import 'package:weather_app/shared/offline/raw_data.dart';
import 'package:weather_app/utils/helpers.dart';

class City {
  final String name;
  final double lat;
  final double lng;
  final String country;

  City.fromJSON(Map<String, String> json)
      : name = json['city'] ?? 'No Name',
        lat = double.tryParse(json['lat']!) ?? -1,
        lng = double.tryParse(json['lng']!) ?? -1,
        country = json['country'] ?? 'No Country';
}

final List<City> cities =
    citiesJSON.map((json) => City.fromJSON(json)).toList();
Map<String, int> cityID = citiesJSON
    .map((json) => cityNameFromJSON(json))
    .toList()
    .asMap()
    .map((index, city) => MapEntry(city, index));
