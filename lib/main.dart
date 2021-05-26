import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photoblogapp/Homepage/homePageHelper.dart';
import 'package:photoblogapp/landingPage/landingHelpers.dart';
import 'package:photoblogapp/landingPage/landingServices.dart';
import 'package:photoblogapp/landingPage/landingUtils.dart';
import 'package:photoblogapp/screens/Feeds/feedHelpers.dart';
import 'package:photoblogapp/screens/splashScreen.dart';
import 'package:photoblogapp/services/FirebaseOperations.dart';
import 'package:photoblogapp/services/authentication.dart';
import 'package:photoblogapp/utils/UploadPage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        child: MaterialApp(
          home: Splashscreen(),
        ),
        providers: [
          ChangeNotifierProvider(create: (_) => FeedHelpers()),
          ChangeNotifierProvider(create: (_) => UploadPost()),
          ChangeNotifierProvider(create: (_) => HomepageHelper()),
          ChangeNotifierProvider(create: (_) => landingUtils()),
          ChangeNotifierProvider(create: (_) => FirebaseOperations()),
          ChangeNotifierProvider(create: (_) => LandingHelpers()),
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => LandingServices()),
        ]);
//
  }
}
