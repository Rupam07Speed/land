import 'package:flutter/material.dart';
import 'package:land_registration/constant/app_color.dart';

class CustomTex extends StatelessWidget {
  final String text;
  final double? fontsize;
  final Color? fontColor;
  final FontWeight? fWeight;
  final TextAlign? textAlign;
  final TextDecoration? txtDecoration;
  const CustomTex(
      {super.key,
      required this.text,
      this.fontsize = 12,
      this.fontColor,
      this.fWeight = FontWeight.w600,
      this.textAlign = TextAlign.center,
      this.txtDecoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      style: customTextStyle(),
    );
  }

  TextStyle customTextStyle() {
    return TextStyle(
        fontSize: fontsize,
        color: fontColor ?? AppColors.blackColor,
        fontWeight: fWeight,
        decoration: txtDecoration,
        letterSpacing: 0.50);
  }
}
