import 'package:weather_app/shared/extensions/string_ext.dart';
import 'package:weather_app/utils/helpers.dart';

class WeatherModel {
  final String temp;
  final String city;
  final String desc;
  final String icon;
  final String tempHi;
  final String tempLow;
  WeatherModel(
    this.temp,
    this.city,
    this.desc,
    this.icon,
    this.tempHi,
    this.tempLow,
  );

  WeatherModel.fromMap(Map<String, dynamic> json)
      : temp = json['main']['temp'].toString(),
        city = json['name'],
        desc = json['weather'][0]['description'].toString().capitalize(),
        icon = json['weather'][0]['icon'],
        tempLow = json['main']['temp_min'],
        tempHi = json['main']['temp_max'];

  factory WeatherModel.fromJSON(Map<String, dynamic> json) {
    num temp = json['main']['temp'];
    num tempHi = json['main']['temp_max'];
    num tempLow = json['main']['temp_min'];

    return WeatherModel(
      temp.toStringAsPrecision(3),
      json['name'],
      json['weather'][0]['description'].toString().capitalize(),
      imageUrl(json['weather'][0]['icon']),
      tempHi.toStringAsPrecision(3),
      tempLow.toStringAsPrecision(3),
    );
  }
}
