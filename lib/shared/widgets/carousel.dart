import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/state/bloc/weather_bloc.dart';
import 'package:weather_app/state/cubit/favourites_index_cubit.dart';
import 'package:weather_app/shared/widgets/weather_tile.dart';
import 'package:weather_app/utils/dialog_box.dart';

import 'button.dart';

class Carousel extends StatelessWidget {
  final double width;

  const Carousel({super.key, required this.width});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 240,
          width: width,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoaded) {
                List<WeatherTile> tiles = state.data
                    .map(
                      (model) => WeatherTile(model: model),
                    )
                    .toList();
                return CarouselSlider(
                  items: tiles,
                  options: CarouselOptions(
                    height: 240,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.4,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                );
              } else if (state is WeatherLoading) {
                return CarouselSlider(
                  items: const [
                    SpinKitWave(
                      color: Colors.white,
                      size: 70,
                    )
                  ],
                  options: CarouselOptions(
                    height: 240,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.4,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Button(
              color: Colors.white,
              child: const Icon(
                Icons.add,
                size: 25,
                color: Colors.purple,
              ),
              onTap: () {
                context.read<FavouritesQueryCubit>().refresh();
                displayOptions(context).then((value) => context
                    .read<WeatherBloc>()
                    .add(
                        GetDefaultData(context.read<FavouritesCubit>().state)));
              }),
        )
      ],
    );
  }
}
