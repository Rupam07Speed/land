import 'package:flutter/material.dart';
import 'package:land_registration/screens/about_container.dart';
import 'package:land_registration/screens/contact_container.dart';
import 'package:land_registration/screens/feature_container.dart';
import 'package:land_registration/screens/home_container.dart';
import 'package:land_registration/screens/our_story_container.dart';
import 'package:land_registration/screens/review_container.dart';
import 'package:land_registration/screens/the_app_container.dart';
import 'package:land_registration/widget/nav_bar.dart';
import '../constant/utils.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final ScrollController _scrollController = ScrollController();
  late bool showFloatingButton = false;
  double pixel = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      pixel = _scrollController.position.pixels;
      print("pixels : $pixel");
    });
    if (_scrollController.offset >= 500) {
      if (!showFloatingButton) {
        setState(() {
          showFloatingButton = true;
        });
      }
    } else {
      if (showFloatingButton) {
        setState(() {
          showFloatingButton = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    if (width > 600) {
      width = 590;
      isDesktop = true;
    }
    return Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              // Top Header
              NavBar(
                scrollController: _scrollController,
              ),
              // const Material(
              //   elevation: 0,
              //   child: Padding(
              //     padding: EdgeInsets.only(
              //         left: 150.0, top: 15, right: 50, bottom: 15),
              //     child: HeaderWidget(),
              //   ),
              // ),
              //main header section -------------------
              const HomeContainer(),
              // Padding(
              //   padding: const EdgeInsets.only(left: 150.0, top: 0, right: 150),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       Expanded(child: const LeftDescription()),
              //       Expanded(
              //         child: Container(
              //           width: 600,
              //           height: 804,
              //           child: SvgPicture.asset(
              //             'assets/background_svg.svg',
              //             height: 20.0,
              //             width: 20.0,
              //             allowDrawingOutsideViewBox: true,
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 100,
              // ),

              //main app section --------------------
              TheAppContainer(
                pixel: pixel,
              ),
              FeatureContainer(
                pixel: pixel,
              ),
              AboutContainer(
                pixel: pixel,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CustomAnimatedContainer('Contract Owner', () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => const CheckPrivateKey(
              //       //               val: "owner",
              //       //             )));
              //       Navigator.of(context).pushNamed(
              //         '/login',
              //         arguments: "owner",
              //       );
              //     }),
              //     CustomAnimatedContainer('Land Inspector', () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => const CheckPrivateKey(
              //       //               val: "LandInspector",
              //       //             )));
              //       Navigator.of(context).pushNamed(
              //         '/login',
              //         arguments: "LandInspector",
              //       );
              //     }),
              //     CustomAnimatedContainer('User', () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => const CheckPrivateKey(
              //       //               val: "UserLogin",
              //       //             )));
              //       Navigator.of(context).pushNamed(
              //         '/login',
              //         arguments: "UserLogin",
              //       );
              //     }),
              //   ],
              // ),
              //upper part needs to work on-------------------rest of the code
              OurStoryContainer(
                pixel: pixel,
              ),
              ReviewsContainer(
                pixel: pixel,
              ),
              ContactContainer(
                pixel: pixel,
              ),
            ],
          ),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
        floatingActionButton: Visibility(
          visible: showFloatingButton,
          child: FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(0,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            child: Icon(Icons.arrow_upward),
          ),
        ));
  }
}
