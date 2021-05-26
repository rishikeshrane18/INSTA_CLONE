import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photoblogapp/utils/UploadPage.dart';
import 'package:provider/provider.dart';

class FeedHelpers with ChangeNotifier{
  Widget appBar(BuildContext context){
    return AppBar(
      backgroundColor:  Color(0xffE2AD21),
      centerTitle: true,
      actions: [
        IconButton(icon: Icon(Icons.camera_alt_outlined,color: Colors.white,), onPressed: (){
        Provider.of<UploadPost>(context,listen: false).selectPostImageType(context);
        })
      ],
      title:  Text(
        "FEEDS",
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 32),
      ),
    );
  }

  Widget feedBody(BuildContext context){
    return SingleChildScrollView(

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: SizedBox(
                    height: 500,
                      width: 400,
                      child: Text('No Post'),
                  ),
                );
              }else{
                  return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot){

                    }).toList(),
                  );
              }
            },
          ),
        height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
          ),
        ),
      ),
    );
  }

  Widget loadPosts(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      return ListView(children : snapshot.data.docs.map((DocumentSnapshot documentSnapshot){
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 20,
                    backgroundImage: NetworkImage(documentSnapshot['userimage']),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(documentSnapshot['caption']),
                      ),
                      Container(
                        child: Text(documentSnapshot['username']),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                child: Image.network(documentSnapshot['postimage']),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 80,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Icon(EvaIcons.heart, color: Colors.red,size: 22,),
                      ),
                      Text('0'),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Icon(EvaIcons.messageCircle, color: Colors.blue,size: 22,),
                      ),
                      Text('0'),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.camera, color: Colors.greenAccent,size: 22,),
                      ),
                      Text('0'),
                    ],
                  ),
                )
              ],
            ),
            Spacer(),

          ],
        ),
      );
      }).toList());
  }

}