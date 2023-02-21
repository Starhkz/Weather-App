import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/features/model/city.dart';
import 'package:weather_app/shared/styling/colors.dart';
import 'package:weather_app/shared/widgets/button.dart';
import 'package:weather_app/shared/widgets/city_tile.dart';
import 'package:weather_app/shared/widgets/text_box.dart';
import 'package:weather_app/state/cubit/favourites_index_cubit.dart';

Future<void> displayOptions(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextArea(
          hintText: 'Search',
          clicked: () => {},
          formText: (query) =>
              context.read<FavouritesQueryCubit>().query(query),
        ),
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.lightBack,
        content: BlocBuilder<FavouritesQueryCubit, List<City>>(
          builder: (context, result) {
            return BlocBuilder<FavouritesCubit, List<int>>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: 300,
                    width: 250,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: result.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CityTile(
                            city: result[index],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        actions: <Widget>[
          Button(
            child: Text("OK", style: GoogleFonts.roboto(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> searchDisplay(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextArea(
          hintText: 'Search',
          clicked: () => {},
          formText: (query) =>
              context.read<FavouritesQueryCubit>().query(query),
        ),
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.lightBack,
        content: BlocBuilder<FavouritesQueryCubit, List<City>>(
          builder: (context, result) {
            return SingleChildScrollView(
              child: SizedBox(
                height: 300,
                width: 75,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: result.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Button(
                          width: 70,
                          height: 50,
                          color: Colors.deepPurpleAccent,
                          child: Text(result[index].name,
                              style: GoogleFonts.roboto(color: Colors.white)),
                          onTap: () {
                            context
                                .read<MainCardCubit>()
                                .setDataFromSearch(result[index]);
                            Navigator.pop(context);
                          },
                        ));
                  },
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          Button(
            child: Text("OK", style: GoogleFonts.roboto(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
