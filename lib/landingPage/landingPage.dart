import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photoblogapp/Homepage/homePage.dart';
import 'package:photoblogapp/landingPage/landingHelpers.dart';
import 'package:photoblogapp/services/authentication.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff232228),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Provider.of<LandingHelpers>(context, listen: false)
                .bodyImage(context),
            new Padding(padding: const EdgeInsets.only(top: 60)),
            Provider.of<LandingHelpers>(context, listen: false)
                .loginText(context),
            new Padding(padding: const EdgeInsets.only(top: 70)),
            Provider.of<LandingHelpers>(context, listen: false)
                .mainButton(context),
            new Padding(padding: const EdgeInsets.only(top: 30)),
          ],
        ),
      ),
    );
  }
}
