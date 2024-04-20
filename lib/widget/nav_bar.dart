import 'package:flutter/material.dart';
import 'package:land_registration/constant/app_color.dart';
import 'package:land_registration/constant/common_container.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:land_registration/constant/routes.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required this.scrollController}) : super(key: key);
  final ScrollController scrollController;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileNavBar(),
      desktop: (BuildContext context) => DeskTopNavBar(
          context: context, scrollController: widget.scrollController, h: h),
    );
  }
}

Widget MobileNavBar() {
  return Container(
    color: AppColors.primaryColor,
    height: 60,
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.menu,
          color: AppColors.whiteColor,
        ),
        navLogo(),
      ],
    ),
  );
}

Widget DeskTopNavBar({
  required BuildContext context,
  required ScrollController scrollController,
  required double h,
}) {
  return Container(
    color: AppColors.primaryColor,
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        navLogo(),
        Row(
          children: [
            navButton('Home', 0, scrollController, context),
            // navButton(  'users', (h * 3) + (h * 0.165), scrollController, context),
            navButton(
                'Feature', (h * 2) + (h * 0.165), scrollController, context),
            navButton(
                'About Us', (h * 5.4) + (h * 0.165), scrollController, context),
            navButton(
                'Reviews', (h * 6.3) + (h * 0.165), scrollController, context),
            navButton(
                'Contact', (h * 7.1) + (h * 0.165), scrollController, context),
            feUserDropdown(context, scrollController, h),
          ],
        ),
      ],
    ),
  );
}

Widget navButton(String text, double scrollOffset,
    ScrollController scrollController, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    child: TextButton(
      onPressed: () {
        if (text == 'Users') {
          Navigator.pushNamed(context, './users');
        } else {
          scrollController.animateTo(
            scrollOffset,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Text(
        text,
        style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
      ),
    ),
  );
}

Widget feUserDropdown(
    BuildContext context, ScrollController scrollController, double h) {
  return DropdownButtonHideUnderline(
    // This hides the underline of DropdownButton
    child: DropdownButton<String>(
      icon: Icon(Icons.arrow_downward, color: AppColors.whiteColor),
      dropdownColor: AppColors.primaryColor,
      style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
      items: <String>['users', 'Inspector', 'admin'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: CustomTextButton(
            txt: value,
            onpressed: () {
              if (value == 'admin') {
                Navigator.of(context).pushNamed('/login', arguments: "owner");
              } else if (value == 'users') {
                Navigator.of(context)
                    .pushNamed('/login', arguments: "UserLogin");
              } else if (value == 'Inspector') {
                Navigator.of(context)
                    .pushNamed('/login', arguments: "LandInspector");
              }
              // You can extend with other conditions if necessary
            },
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        // This can be empty since the buttons are handling their own actions
      },
      hint: Text("Sign In",
          style: TextStyle(color: AppColors.whiteColor, fontSize: 20)),
    ),
  );
}

Widget navLogo() {
  return Container(
    child: Text(
      "Land Registration\nSystem",
      style: TextStyle(color: AppColors.whiteColor),
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:land_registration/constant/app_color.dart';
// import 'package:responsive_builder/responsive_builder.dart';

// import 'package:land_registration/constant/routes.dart';

// class NavBar extends StatefulWidget {
//   const NavBar({Key? key, required this.scrollController}) : super(key: key);
//   final ScrollController scrollController;

//   @override
//   _NavBarState createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     return ScreenTypeLayout.builder(
//       mobile: (BuildContext context) => MobileNavBar(),
//       desktop: (BuildContext context) => DeskTopNavBar(
//           context: context, scrollController: widget.scrollController, h: h),
//     );
//   }
// }

// Widget MobileNavBar() {
//   return Container(
//     color: AppColors.primaryColor,
//     height: 60,
//     padding: EdgeInsets.symmetric(horizontal: 25),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Icon(
//           Icons.menu,
//           color: AppColors.whiteColor,
//         ),
//         navLogo(),
//       ],
//     ),
//   );
// }

// Widget DeskTopNavBar(
//     {required BuildContext context,
//     required ScrollController scrollController,
//     required double h}) {
//   return Container(
//     color: AppColors.primaryColor,
//     height: 60,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         navLogo(),
//         Row(
//           children: [
//             navButton('Home', 0, scrollController, context),
//             navButton('users', (h * 3) + (h * 0.165), scrollController,
//                 context), // Here's where we use the navButton1
//             navButton(
//                 'features', (h * 2) + (h * 0.165), scrollController, context),
//             navButton(
//                 'About Us', (h * 5.4) + (h * 0.165), scrollController, context),
//             navButton(
//                 'Reviews', (h * 6.3) + (h * 0.165), scrollController, context),
//             navButton(
//                 'Contact', (h * 7.1) + (h * 0.165), scrollController, context),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Widget navButton(String text, double scrollOffset,
//     ScrollController scrollController, BuildContext context) {
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 4),
//     child: TextButton(
//       onPressed: () {
//         if (text == 'Users') {
//           Navigator.pushNamed(context, './users');
//         } else {
//           scrollController.animateTo(
//             scrollOffset,
//             duration: Duration(milliseconds: 500),
//             curve: Curves.easeInOut,
//           );
//         }
//       },
//       child: Text(
//         text,
//         style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
//       ),
//     ),
//   );
// }

// Widget navButton1(BuildContext context) {
//   return Container(
//     child: TextButton(
//       onPressed: () {
//         Navigator.pushNamed(context, './users');
//       },
//       child: Text(
//         "users",
//         style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
//       ),
//     ),
//   );
// }

// Widget navLogo() {
//   return Container(
//     child: Text(
//       "Land Registration\nSystem",
//       style: TextStyle(color: AppColors.whiteColor),
//     ),
//   );
// }
