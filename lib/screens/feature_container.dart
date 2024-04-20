import 'package:flutter/material.dart';
import 'package:land_registration/constant/app_color.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FeatureContainer extends StatelessWidget {
  final double pixel;
  const FeatureContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      // mobile: (BuildContext context) => MobileHomeContainer(),
      desktop: (BuildContext context) => DeskTopFeatureContainer(
        pixel: pixel,
      ),
    );
  }
}

class DeskTopFeatureContainer extends StatelessWidget {
  final double pixel;
  const DeskTopFeatureContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h,
      width: w,
      padding: EdgeInsets.symmetric(horizontal: w / 10, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondaryColor, AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: pixel >= 1030 ? 1.0 : 0.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Features',
                    style: TextStyle(
                        fontSize: w / 20,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   "I'm a thile. Click here to add your own text and edit me.",
                  //   style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              AnimatedPadding(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.only(left: pixel >= 1030 ? 0 : 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.whiteColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "High-Performance\nSpeed",
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Our system expedites and secures land registration within minutes and uniquely employs smart contracts to authenticate.",
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.whiteColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "User-Friendly\nInterface",
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Our platform features a user-friendly interface, making navigation and interaction intuitive and accessible for all users.",
                              style: TextStyle(
                                  color: AppColors.whiteColor, fontSize: 16),
                              textAlign: TextAlign.justify),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock,
                            color: AppColors.whiteColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Secure User Authentication\nand Transactions",
                              style: TextStyle(
                                  color: AppColors.whiteColor, fontSize: 18),
                              textAlign: TextAlign.justify),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Our blockchain technology ensures secure user authentication and transactions, enhancing security and transparency.",
                              style: TextStyle(
                                  color: AppColors.whiteColor, fontSize: 16),
                              textAlign: TextAlign.justify),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
