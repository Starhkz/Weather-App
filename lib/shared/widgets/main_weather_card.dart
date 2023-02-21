import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/features/model/weather.dart';
import 'package:weather_app/shared/constants.dart';
import 'package:weather_app/state/bloc/weather_bloc.dart';

class MainWeatherCard extends StatelessWidget {
  final WeatherModel model;
  const MainWeatherCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 250,
          height: 150,
          decoration: BoxDecoration(
              color: const Color.fromARGB(33, 104, 58, 183),
              borderRadius: BorderRadius.circular(15)),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is NoInternet) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      StringConstants.noInternet,
                      style: GoogleFonts.roboto(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const Center(child: CircularProgressIndicator()),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      model.city,
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${model.temp}°C',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      '${StringConstants.high} ${model.tempHi} ${StringConstants.degreeCelcius}',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      '${StringConstants.low} ${model.tempLow} ${StringConstants.degreeCelcius}',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
        SizedBox(
          width: 200,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              bool isconnected = false;
              if (state is NoInternet) {
                isconnected = false;
              }
              if (state is WeatherLoaded) {
                isconnected = true;
              }
              return Stack(
                children: [
                  ImageViewer(
                    imageUrl: model.icon,
                    isConnected: isconnected,
                  ),
                  Visibility(
                    visible: (isconnected),
                    child: Positioned(
                      bottom: 2,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            model.desc,
                            style: GoogleFonts.roboto(
                              color: Colors.white70,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class ImageViewer extends StatefulWidget {
  final String imageUrl;
  final bool isConnected;
  const ImageViewer(
      {super.key, required this.imageUrl, required this.isConnected});

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    if (widget.isConnected) {
      return Center(
        child: Image.network(
          widget.imageUrl,
          height: 150,
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
