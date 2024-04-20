import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:land_registration/constant/app_color.dart';
import 'package:land_registration/constant/constraints.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      // mobile: (BuildContext context) => MobileHomeContainer(),
      desktop: (BuildContext context) => const DesktopHomeContainer(),
    );
  }
}

class DesktopHomeContainer extends StatelessWidget {
  const DesktopHomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.color2,
            AppColors.color1,
            AppColors.secondaryColor
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: w / 10, vertical: 20),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: FadeInRight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blockchain\nEnabled Land\nRegistration\nSystem',
                      style: TextStyle(
                          fontSize: w / 20,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Text(
                    //   "Try it yourself. Download now.",
                    //   style:
                    //       TextStyle(color: AppColors.whiteColor, fontSize: 16),
                    // ),
                  ],
                ),
              )),
              Expanded(
                child: Container(
                  height: h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(illustration1),
                          fit: BoxFit.contain)),
                ),
              ),
            ],
          ),
          Positioned(
            top: h * 0.25,
            right: w * 0.02,
            child: FadeInRight(
              child: SizedBox(
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      phonecart,
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
