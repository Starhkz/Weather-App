import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/state/cubit/favourites_index_cubit.dart';
import 'package:weather_app/features/model/city.dart';
import 'package:weather_app/shared/styling/colors.dart';

import 'button.dart';

class CityTile extends StatefulWidget {
  final City city;
  const CityTile({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  State<CityTile> createState() => _CityTileState();
}

class _CityTileState extends State<CityTile> {
  @override
  Widget build(BuildContext context) {
    int index = cityID[widget.city.name]!;
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(212, 124, 245, 0.808),
            Color.fromRGBO(224, 217, 255, 100),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Center(
              child: Text(widget.city.name,
                  style: GoogleFonts.roboto(color: Colors.white)),
            ),
          ),
          Expanded(
            child: Center(
              child: Button(
                onTap: () {
                  context.read<FavouritesCubit>().isFavourite(index)
                      ? context.read<FavouritesCubit>().remove(index)
                      : context.read<FavouritesCubit>().add(index);

                  setState(() {});
                },
                color: context.read<FavouritesCubit>().isFavourite(index)
                    ? Colors.red
                    : AppColors.lightGreen,
                child: Icon(
                  context.read<FavouritesCubit>().isFavourite(index)
                      ? Icons.cancel
                      : Icons.check,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
