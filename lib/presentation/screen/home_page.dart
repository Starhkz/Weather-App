import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/shared/styling/colors.dart';
import 'package:weather_app/state/bloc/weather_bloc.dart';
import 'package:weather_app/state/cubit/favourites_index_cubit.dart';
import 'package:weather_app/features/model/city.dart';
import 'package:weather_app/features/model/weather.dart';
import 'package:weather_app/shared/widgets/button.dart';
import 'package:weather_app/shared/widgets/carousel.dart';
import 'package:weather_app/shared/widgets/main_weather_card.dart';
import 'package:weather_app/utils/dialog_box.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double scaleFactor = MediaQuery.of(context).size.height / 790;
    scaleFactor = (scaleFactor > 1) ? 1 : scaleFactor;
    scaleFactor = (scaleFactor < 0.8) ? 0.8 : scaleFactor;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is InternetRestored) {
          List<int> favList = context.read<FavouritesCubit>().state;
          context.read<MainCardCubit>().setDataFromSearch(cities[0]);
          context.read<WeatherBloc>().add(GetDefaultData(favList));
        }
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 14, 44, 59),
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Cropped.png'),
                          fit: BoxFit.fill)),
                ),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Color.fromARGB(123, 0, 0, 0),
                    Color.fromARGB(206, 0, 0, 0),
                    Color.fromARGB(251, 0, 0, 0),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                Positioned(
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/House.png',
                      fit: BoxFit.fitWidth,
                      width: width,
                    )),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Colors.transparent, Color.fromARGB(158, 0, 0, 0)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
                SingleChildScrollView(
                  child: Transform.scale(
                    scale: scaleFactor,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Button(
                            height: 50,
                            width: 50,
                            color: AppColors.lilac,
                            child: const Icon(
                              Icons.search,
                              size: 40,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              {
                                context.read<FavouritesQueryCubit>().refresh();
                                await searchDisplay(context);
                              }
                            },
                          ),
                        )),
                        Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Color.fromARGB(158, 0, 0, 0)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                        ),
                        BlocBuilder<MainCardCubit, WeatherModel>(
                          builder: (context, weatherModel) {
                            return MainWeatherCard(
                              model: weatherModel,
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                                color: AppColors.lilac,
                                onTap: () => {
                                      context
                                          .read<MainCardCubit>()
                                          .setDataFromLocation()
                                    },
                                height: 50,
                                width: 50,
                                child: const Icon(
                                  Icons.gps_fixed,
                                  size: 40,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        Carousel(
                          width: width,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
