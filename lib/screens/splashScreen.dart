import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photoblogapp/landingPage/landingPage.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
              child: LandingPage(),
              type: PageTransitionType.topToBottom,
            )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff232228),
      body: SingleChildScrollView(
        child: Column(
          children: [
            new Padding(padding: const EdgeInsets.only(top: 60)),
            Center(
              child: SvgPicture.asset(
                "assets/ourlogo.svg",
                height: 400,
                width: 251,
              ),
            ),
            new Padding(padding: const EdgeInsets.only(top: 80)),
            Text(
              "PHoTo - BLoG",
              style: TextStyle(
                  color: Color(0xffE2AD21),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 48),
            ),
            new Padding(padding: const EdgeInsets.only(top: 10)),
            Text(
              "take your photo to the moon !",
              style: TextStyle(
                  color: Color(0xffF7F7FC),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
