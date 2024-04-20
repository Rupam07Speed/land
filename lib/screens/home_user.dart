import 'package:flutter/material.dart';
import 'package:land_registration/screens/feature_container.dart';
import 'package:land_registration/screens/home_container.dart';
import 'package:land_registration/widget/nav_bar.dart';
import '../constant/utils.dart';

class home_user extends StatefulWidget {
  const home_user({Key? key}) : super(key: key);

  @override
  _home_userState createState() => _home_userState();
}

class _home_userState extends State<home_user> {
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

              const HomeContainer(),

              //main app section --------------------

              FeatureContainer(
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
