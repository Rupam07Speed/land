import 'package:flutter/material.dart';
import 'package:land_registration/constant/common_container.dart';
import 'package:land_registration/constant/constraints.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AboutContainer extends StatelessWidget {
  final double pixel;
  const AboutContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      // mobile: (BuildContext context) => MobileHomeContainer(),
      desktop: (BuildContext context) => DesktopAboutContainer(
        pixel: pixel,
      ),
    );
  }
}

class DesktopAboutContainer extends StatelessWidget {
  final double pixel;
  const DesktopAboutContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonContainer(
          text1: "01",
          text2: "Contract Owner",
          text3:
              "The contract owner assumes a managerial role, particularly in appointing land inspectors.",
          image: contractOwner,
          imageLeft: false,
          pixel: pixel,
          pxlForthiscontainer: 1650,
        ),
        CommonContainer(
          text1: "02",
          text2: "Land Inspector",
          text3:
              "The land inspectors are responsible for verifying users, authenticating land ownership, and overseeing land transfer processes.",
          image: landInspector,
          imageLeft: true,
          pixel: pixel,
          pxlForthiscontainer: 2125,
        ),
        CommonContainer(
          text1: "03",
          text2: "User",
          text3:
              "Users of the system can register, add their land information, request verifications, and engage in land transactions, whether buying or selling property.",
          image: user,
          imageLeft: false,
          pixel: pixel,
          pxlForthiscontainer: 2590,
        )
      ],
    );
  }
}
