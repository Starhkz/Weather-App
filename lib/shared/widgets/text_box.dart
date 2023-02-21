import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/shared/styling/colors.dart';

class TextArea extends StatefulWidget {
  const TextArea({
    Key? key,
    required this.hintText,
    required this.clicked,
    required this.formText,
  }) : super(key: key);
  final String hintText;
  final void Function() clicked;
  final void Function(String text) formText;

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 275,
      constraints: const BoxConstraints(minHeight: 40),
      child: TextFormField(
        onChanged: (newValue) => widget.formText(newValue),
        onTap: () => setState(() {
          widget.clicked();
        }),
        maxLines: 6,
        minLines: 1,
        style: const TextStyle(fontSize: 20, color: Colors.grey),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.roboto(
              fontSize: 14, color: Colors.white60, fontWeight: FontWeight.bold),
          filled: true,
          fillColor: AppColors.darkBack,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
