import 'package:flutter/material.dart';
import 'package:photoblogapp/screens/Feeds/feedHelpers.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  const Feed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff232228),
      drawer: Drawer(),
      appBar: Provider.of<FeedHelpers>(context,listen: false).appBar(context),
      body: Provider.of<FeedHelpers>(context,listen: false).feedBody(context),
    );
  }
}
