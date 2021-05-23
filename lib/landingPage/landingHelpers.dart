import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photoblogapp/Homepage/homePage.dart';
import 'package:photoblogapp/landingPage/landingServices.dart';
import 'package:photoblogapp/services/authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LandingHelpers with ChangeNotifier {
  Widget bodyImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.width * 0.95,
      child: SvgPicture.asset(
        "assets/loginnew.svg",
      ),
    );
  }

  Widget loginText(BuildContext context) {
    return Positioned(
      top: 800,
      left: 10,
      child: Container(
        child: Center(
            child: Text(
          'LOGIN',
          style: TextStyle(
              color: Color(0xffE2AD21),
              fontFamily: 'Poppins',
              fontSize: 32,
              fontWeight: FontWeight.w700),
        )),
      ),
    );
  }

  Widget mainButton(BuildContext context) {
    return Positioned(
        top: 600,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  emailAuthSheet(context);
                },
                child: Container(
                  child: Icon(EvaIcons.emailOutline, color: Colors.yellow),
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.yellow,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<Authentication>(context, listen: false)
                      .signInWithGoogle()
                      .whenComplete(() {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: HomePage(),
                            type: PageTransitionType.leftToRight));
                  });
                },
                child: Container(
                  child: Icon(EvaIcons.googleOutline, color: Colors.red),
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  Provider.of<LandingServices>(context, listen: false)
                      .passwordLessSignIn(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                          color: Colors.blue,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Color(0xffF7F7FC),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Provider.of<LandingServices>(context, listen: false)
                                .logInSheet(context);
                          }),
                      MaterialButton(
                          color: Colors.red,
                          child: Text(
                            'SIGNIN',
                            style: TextStyle(
                                color: Color(0xffF7F7FC),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Provider.of<LandingServices>(context, listen: false)
                                .signInSheet(context);
                          }),
                    ],
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
            ),
          );
        });
  }
}
