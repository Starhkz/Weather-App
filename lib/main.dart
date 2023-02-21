import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/services/storage.dart';
import 'package:weather_app/state/cubit/favourites_index_cubit.dart';
import 'package:weather_app/features/model/weather.dart';
import 'package:weather_app/presentation/screen/home_page.dart';

import 'features/model/city.dart';
import 'shared/offline/raw_data.dart';
import 'state/bloc/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferenceLocalStorage.getInstance();
  List<int> list = await prefs.getStringList();
  runApp(MyApp(
    favList: list,
    pref: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final List<int> favList;
  final SharedPreferenceLocalStorage pref;
  const MyApp({super.key, required this.favList, required this.pref});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavouritesCubit>(
          create: (_) => FavouritesCubit(favList, pref),
        ),
        BlocProvider<FavouritesQueryCubit>(
          create: (context) => FavouritesQueryCubit(cities),
        ),
        BlocProvider<WeatherBloc>(create: (_) => WeatherBloc(favList)),
        BlocProvider<MainCardCubit>(
            create: (_) => MainCardCubit(WeatherModel.fromJSON(dummyJSON))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      ),
    );
  }
}
