import 'package:flutter/material.dart';
import 'package:land_registration/widget/custom_text.dart';
import '../constant/app_color.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? btncolor;
  final Color? textColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? fSize;
  final FontWeight? fontWeight;
  final double? borderRad;
  final Color? bordersideColor;
  final double? borderwidtch;
  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.btncolor,
      this.textColor,
      this.buttonHeight,
      this.buttonWidth,
      this.fSize,
      this.fontWeight,
      this.borderRad,
      this.bordersideColor,
      this.borderwidtch});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: btncolor ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: bordersideColor ?? AppColors.primaryColor,
                  width: borderwidtch ?? 1),
              borderRadius: BorderRadius.circular(borderRad ?? 12)),
          minimumSize: Size(buttonWidth ?? w * 0.4, buttonHeight ?? h * 0.06)),
      child: CustomTex(
          text: text,
          fontsize: fSize ?? 18,
          fWeight: fontWeight,
          fontColor: textColor ?? Colors.white),
    );
  }
}
