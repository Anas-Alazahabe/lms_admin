import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 60,
      decoration: BoxDecoration(
          color: Color(0xFF154957), borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        onPressed: onPressed,
        // style: ElevatedButton.styleFrom(
        //   minimumSize: const Size(300, 70),
        // ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
