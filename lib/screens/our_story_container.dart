import 'package:flutter/material.dart';
import 'package:land_registration/constant/app_color.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OurStoryContainer extends StatelessWidget {
  final double pixel;
  const OurStoryContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (BuildContext contex) => DesktopStoryContainer(
        pixel: pixel,
      ),
    );
  }
}

class DesktopStoryContainer extends StatelessWidget {
  final double pixel;
  const DesktopStoryContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.9,
      width: w,
      padding: EdgeInsets.symmetric(horizontal: w / 10, vertical: 30),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          AppColors.primaryColor,
          AppColors.secondaryColor,
          AppColors.primaryColor
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      )),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: pixel >= 3097 ? 1.0 : 0.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "Our Story",
                style: TextStyle(
                    fontSize: w / 20,
                    fontWeight: FontWeight.bold,
                    height: 1,
                    color: AppColors.whiteColor),
              ),
            ),
            Expanded(
              flex: 1,
              child: AnimatedPadding(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.only(
                  left: pixel >= 3097 ? 0 : w / 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Led by the believe that anyone can grow",
                    //   style:
                    //       TextStyle(fontSize: 16, color: AppColors.whiteColor),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Blockchain's based land-registries enhance security and trust through decentralization and immutability. In contrast, conventional paper-based systems take up to six months for property registration, though digitized methods demand greater security and transparency. Our system expedites and secures land registration within minutes and uniquely employs smart contracts to authenticate without human engagement.",
                      style:
                          TextStyle(fontSize: 16, color: AppColors.whiteColor),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
