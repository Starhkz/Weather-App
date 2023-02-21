import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/features/model/weather.dart';

class WeatherTile extends StatefulWidget {
  final WeatherModel model;
  const WeatherTile({super.key, required this.model});

  @override
  State<WeatherTile> createState() => _WeatherTileState();
}

class _WeatherTileState extends State<WeatherTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 70,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 92, 16, 105),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                  child: Center(
                      child: Text(
                    '${widget.model.temp} °C',
                    style:
                        GoogleFonts.roboto(fontSize: 25, color: Colors.white),
                  )),
                ),
                Container(
                  height: 70,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Color.fromARGB(255, 92, 16, 105)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.model.city,
                            style: GoogleFonts.roboto(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.model.desc,
                            style: GoogleFonts.roboto(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image.network(
            widget.model.icon,
            width: 100,
          ),
        )
      ]),
    );
  }
}
