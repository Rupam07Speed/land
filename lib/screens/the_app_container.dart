import 'package:flutter/material.dart';
import 'package:land_registration/constant/app_color.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TheAppContainer extends StatelessWidget {
  final double pixel;
  const TheAppContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      // mobile: (BuildContext context) => MobileHomeContainer(),
      desktop: (BuildContext context) => DesktopTheAppContainer(
        pixel: pixel,
      ),
    );
  }
}

class DesktopTheAppContainer extends StatelessWidget {
  final double pixel;
  const DesktopTheAppContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return AnimatedOpacity(
      opacity: pixel >= h ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        height: h,
        width: w,
        padding: EdgeInsets.symmetric(horizontal: w / 10, vertical: w / 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AnimatedPadding(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.only(left: pixel >= h ? 0 : 30),
                child: Text(
                  'Revolutionizing Land Registration\nand Ownership',
                  //Revolutionizing Land Registration and Ownership
                  style: TextStyle(
                      fontSize: w / 20, fontWeight: FontWeight.bold, height: 1),
                ),
              ),
            ),
            Expanded(
                child: AnimatedPadding(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.only(left: pixel >= h ? 0 : 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Join more than a million of happy users",
                  //   style: TextStyle(color: AppColors.blackColor, fontSize: 18),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Utilizing blockchain technology for property registration aims to enhance the current system by streamlining, expediting, and fortifying the process, ultimately making property registration more efficient, swift, and secure.",
                      style:
                          TextStyle(color: AppColors.blackColor, fontSize: 20),
                      textAlign: TextAlign.justify),
                  const SizedBox(
                    height: 20,
                  ),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       'Downloadthe App',
                  //       style: TextStyle(
                  //           color: AppColors.blackColor, fontSize: 16),
                  //     ),
                  //     style: ButtonStyle(
                  //       side: MaterialStateProperty.all(
                  //           BorderSide(color: AppColors.blackColor, width: 2)),
                  //       padding: MaterialStateProperty.all(
                  //           EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  //     ))
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
