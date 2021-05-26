import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:photoblogapp/Homepage/homePageHelper.dart';
import 'package:photoblogapp/screens/Chatroom/chatRoom.dart';
import 'package:photoblogapp/screens/Feeds/feeds.dart';
import 'package:photoblogapp/screens/Profile/profile.dart';
import 'package:photoblogapp/services/FirebaseOperations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController homePageController = PageController();
  int pageIndex = 0 ;

  @override
  void initState() {
    // TODO: implement initState

    Provider.of<FirebaseOperations>(context,listen: false).initUserData(context).then((value){
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff232228),
      body: PageView(
        controller: homePageController,
        children: [
          Feed(),
          chatRoom(),
          Profile(),
        ],
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page){
          setState(() {
            pageIndex = page ;
          });
        },
      ),
      bottomNavigationBar: Provider.of<HomepageHelper>(context,listen: false).bottomNavBar(pageIndex, homePageController),
    );
  }
}

