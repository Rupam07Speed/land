import 'package:flutter/material.dart';
import 'package:land_registration/constant/app_color.dart';

class CommonContainer extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String image;
  final bool imageLeft;
  final double pixel;
  final double pxlForthiscontainer;
  const CommonContainer(
      {super.key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.image,
      required this.imageLeft,
      required this.pixel,
      required this.pxlForthiscontainer});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      height: h * 0.8,
      // padding: EdgeInsets.symmetric(horizontal: w / 10, vertical: 30),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: pixel >= pxlForthiscontainer ? 1.0 : 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imageLeft
                ? Expanded(
                    child: AnimatedPadding(
                    duration: const Duration(milliseconds: 500),
                    padding: EdgeInsets.only(
                        left: pixel >= pxlForthiscontainer ? 0 : w / 5),
                    child: Container(
                      height: h * 1.2,
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 0, vertical: 0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.fitWidth),
                      ),
                    ),
                  ))
                : Container(),
            imageLeft
                ? SizedBox(
                    width: w / 15,
                  )
                : Container(),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(
                  left: imageLeft ? 0 : w / 10, right: imageLeft ? w / 10 : 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: imageLeft
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    text1.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    text2,
                    textAlign: imageLeft ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: w / 20,
                        height: 1.1,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    text3,
                    textAlign: imageLeft ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 22,
                    ),
                  ),
                  // CustomTextButton(
                  //   txt: text2,
                  //   onpressed: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => CommonFormForAll(
                  //     //               whichDashboard: text2,
                  //     //             )));
                  //     if (text2 == "Contract Owner") {
                  //       Navigator.of(context).pushNamed(
                  //         '/login',
                  //         arguments: "owner",
                  //       );
                  //     } else if (text2 == "users") {
                  //       Navigator.of(context).pushNamed(
                  //         '/users',
                  //       );
                  //     } else if (text2 == "Land Inspector") {
                  //       Navigator.of(context).pushNamed(
                  //         '/login',
                  //         arguments: "LandInspector",
                  //       );
                  //     } else if (text2 == "User") {
                  //       Navigator.of(context).pushNamed(
                  //         '/login',
                  //         arguments: "UserLogin",
                  //       );
                  //     }
                  //   },
                  // ),
                ],
              ),
            )),
            !imageLeft
                ? SizedBox(
                    width: w / 15,
                  )
                : Container(),
            !imageLeft
                ? Expanded(
                    child: AnimatedPadding(
                    duration: const Duration(milliseconds: 500),
                    padding: EdgeInsets.only(
                        right: pixel >= pxlForthiscontainer ? 0 : w / 5),
                    child: Container(
                      height: h * 1.2,
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 20, vertical: 0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.fitHeight),
                      ),
                    ),
                  ))
                : Container()
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String txt;
  final bool? bgColor;
  final Function()? onpressed;
  const CustomTextButton({
    super.key,
    required this.txt,
    this.bgColor = true,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onpressed,
        child: Text(
          txt,
          style: TextStyle(
              color: bgColor! ? AppColors.primaryColor : AppColors.whiteColor),
        ),
        style: TextButton.styleFrom(
            backgroundColor:
                bgColor! ? AppColors.whiteColor : Colors.transparent,
            shadowColor: bgColor! ? Colors.grey : Colors.transparent,
            elevation: 5,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            minimumSize: const Size(170, 50),
            side: BorderSide(
                color:
                    bgColor! ? AppColors.primaryColor : AppColors.whiteColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(bgColor!
                  ? const Radius.circular(20)
                  : const Radius.circular(0)),
            )));
  }
}
