import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/shared/extensions/connectivity_ext.dart';
import 'package:weather_app/state/cubit/favourites_index_cubit.dart';
import 'package:weather_app/features/model/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  late StreamSubscription connectivitySubscription;

  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }

  final List<int> favList;
  WeatherBloc(this.favList) : super(WeatherInitial()) {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((connectivityResult) async {
      if (!await Connectivity().isConnected()) {
        add(const InternetDisconnected());
      } else {
        add(const InternetConnected());
      }
    });

    on<WeatherEvent>(_onInitial);
    on<GetDefaultData>(_getDefaultData);
    on<InternetDisconnected>(
      (event, emit) {
        emit(NoInternet());
      },
    );
    on<InternetConnected>(
      (event, emit) {
        emit(InternetRestored());
      },
    );
  }

  void _onInitial(WeatherEvent event, Emitter<WeatherState> emit) async {
    if (!await Connectivity().isConnected()) {}
  }

  void _getDefaultData(GetDefaultData event, Emitter<WeatherState> emit) async {
    final state = this.state;
    if (state is! NoInternet) {
      emit(WeatherLoading());

      List<WeatherModel> data = await getWeatherData(event.favList);
      emit(WeatherLoaded(data: data));
    }
  }
}
