import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photoblogapp/services/FirebaseOperations.dart';
import 'package:provider/provider.dart';

class HomepageHelper with ChangeNotifier{
  Widget bottomNavBar(int index , PageController pageController){
    return CustomNavigationBar(
    currentIndex: index,
    bubbleCurve: Curves.bounceIn,
    scaleCurve: Curves.decelerate,
    selectedColor: Colors.blue,
    unSelectedColor: Colors.white,
    strokeColor: Colors.blue,
    scaleFactor: 0.5,
    iconSize: 30,
    onTap: (val){
      index = val;
      pageController.jumpToPage(val);
      notifyListeners();
    },
    backgroundColor: Colors.blueGrey.withOpacity(0.4),
    items:[
      CustomNavigationBarItem(icon: Icon(EvaIcons.home)),
      CustomNavigationBarItem(icon: Icon(Icons.message_rounded)),
      CustomNavigationBarItem(icon: CircleAvatar(
        radius: 35.0,
        backgroundColor: Colors.white,
       // backgroundImage: NetworkImage(Provider.of<FirebaseOperations>(context,listen: false).initUserImage),
      )),


    ]);
  }
}