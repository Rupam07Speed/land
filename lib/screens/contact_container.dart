import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:land_registration/constant/app_color.dart';
import 'package:land_registration/constant/common_container.dart';
import 'package:land_registration/constant/constraints.dart';
import 'package:land_registration/widget/custom_text_form_field.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ContactContainer extends StatelessWidget {
  final double pixel;
  const ContactContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (BuildContext context) => DesktopContactContainer(
        pixel: pixel,
      ),
    );
  }
}

class DesktopContactContainer extends StatelessWidget {
  final double pixel;
  const DesktopContactContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 2,
      width: w,
      child: Column(
        children: [
          AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: pixel >= 4300 ? 1.0 : 0.0,
              child: containerOne(h, w)),
          AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: pixel >= 4842 ? 1.0 : 0.0,
              child: containerTwo(h, w))
        ],
      ),
    );
  }

  Widget containerOne(double h, double w) {
    return Container(
      height: h,
      padding: EdgeInsets.symmetric(horizontal: w / 20, vertical: 30),
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              "For Any Assistance\nRequired Please\nReach Out",
              style: TextStyle(
                  fontSize: w / 20,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  color: AppColors.whiteColor),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                        child: CustomTextfomField(labeltxt: "First Name *")),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomTextfomField(labeltxt: "Last Name *")),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomTextfomField(labeltxt: "Email *"),
                const SizedBox(
                  height: 20,
                ),
                const CustomTextfomField(
                    labeltxt: "Leave us a message", isExpand: 5),
                const SizedBox(
                  height: 50,
                ),
                CustomTextButton(
                  txt: "Submit",
                  bgColor: false,
                  onpressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget containerTwo(double h, double w) {
    return Container(
      height: h * 0.8,
      padding: EdgeInsets.symmetric(horizontal: w / 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.play_circle,
                  color: AppColors.primaryColor,
                ),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                  shadowColor: MaterialStatePropertyAll(Colors.transparent),
                ),
                label: Text(
                  "Go On",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tel: 123-456-7890",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Email: info@demo.com",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "500 Gulshan Street",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Dhaka, 1200",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.facebook)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.twitter)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.linkedin))
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Image.asset(appStore),
                  const SizedBox(
                    width: 30,
                  ),
                  Image.asset(playStore)
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text("© 2035 by Go On.")
            ],
          )
        ],
      ),
    );
  }
}
