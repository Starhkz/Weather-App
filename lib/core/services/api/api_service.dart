import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:weather_app/shared/constants.dart';
import 'package:weather_app/shared/extensions/connectivity_ext.dart';

class ApiService implements Api {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: ApiConstants.baseUrl),
  );

  @override
  Future getWeatherFromCity(String city, {Map<String, dynamic>? params}) async {
    String endpoint =
        '${ApiConstants.query}$city&appid=${ApiConstants.apiKey}&units=metric';
    try {
      if (!await Connectivity().isConnected()) {
        return;
      }

      final request = await _dio.get(
        endpoint,
        queryParameters: params ?? {},
      );
      if (request.statusCode! >= 200 && request.statusCode! < 300) {
        return request.data;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return e.response;
      }
      return e.response!.statusCode;
    }
  }

  @override
  Future getWeatherFromLocation(LocationData currentLocation,
      {Map<String, dynamic>? params}) async {
    String endpoint =
        '${ApiConstants.locationQuery}lat=${currentLocation.latitude}&lon=${currentLocation.longitude}&appid=${ApiConstants.apiKey}&units=metric';
    try {
      if (!await Connectivity().isConnected()) {
        return;
      }

      final request = await _dio.get(
        endpoint,
        queryParameters: params ?? {},
      );
      if (request.statusCode! >= 200 && request.statusCode! < 300) {
        return request.data;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return e.response;
      }
      return e.response!.statusCode;
    }
  }
}

abstract class Api {
  Future getWeatherFromCity(String city, {Map<String, dynamic>? params});
  Future getWeatherFromLocation(LocationData currentLocation,
      {Map<String, dynamic>? params});
}
