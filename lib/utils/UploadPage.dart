import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photoblogapp/landingPage/landingServices.dart';
import 'package:photoblogapp/landingPage/landingUtils.dart';
import 'package:photoblogapp/services/FirebaseOperations.dart';
import 'package:photoblogapp/services/authentication.dart';
import 'package:provider/provider.dart';

class UploadPost with ChangeNotifier{
  TextEditingController captionController = TextEditingController();
  File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String uploadPostImageUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;
  final picker = ImagePicker();
  UploadTask imageUploadTask;

  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    // File _image;
    //  bool _isImageThere = false;
    var uploadPostImageVal = await picker.getImage(source: source);
   // print('hello1');

    uploadPostImageVal == null
        ? print('Select Image')
        : uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImageVal.path);

    uploadPostImage != null
        ? showPostImage(context)
        : print('Image Upload error');

    notifyListeners();
  }

  Future uploadPostImageToFirebase() async{
    Reference imageReference = FirebaseStorage.instance.ref().child(
      'posts/${uploadPostImage.path}/${TimeOfDay.now()}'
    );

    imageUploadTask = imageReference.putFile(uploadPostImage);
    await imageUploadTask.whenComplete((){

    });
    imageReference.getDownloadURL().then((imageUrl){
      uploadPostImageUrl = imageUrl;
    });
    notifyListeners();
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.1,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 4.0,
                color: Colors.white,
              ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(color: Colors.blue,
                    child: Text('Gallery'),
                    onPressed: () {
                  pickUploadPostImage(context, ImageSource.gallery);
                    }),
                MaterialButton(
                    color: Colors.blue, child: Text('Camera'), onPressed: () {
                  pickUploadPostImage(context, ImageSource.camera);
                })
              ],
            )
          ],
        ),

      );
    });
  }
  showPostImage(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.5,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 4.0,
                color: Colors.white,
              ),),
            Padding(padding: const EdgeInsets.only(top: 8,left: 8 ,right: 8),
            child: Container(
              height: 200,
              width: 400,
              child: Image.file(uploadPostImage,fit: BoxFit.contain,),
            ),),
            Padding(padding: const EdgeInsets.only(top: 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(child: Text('RESELECT IMAGE'),onPressed: (){
                  selectPostImageType(context);
                }),
                MaterialButton(color: Colors.blue,child: Text('CONFIRM IMAGE'),onPressed: (){
                  uploadPostImageToFirebase().whenComplete((){
                      editPostSheet(context);
                  });
                }),

              ],
            )
          ],
        ),

      );
    });
  }

  editPostSheet(BuildContext context){
    return showModalBottomSheet(isScrollControlled : true,context: context, builder: (context){
      return Container(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 12),child: Divider(
              thickness: 4.0,
              color: Colors.white,
            ),),
            Container(
              child: Column(
                children: [
                  IconButton(icon: Icon(Icons.image_aspect_ratio,color: Colors.green,), onPressed:(){}),
                  IconButton(icon: Icon(Icons.fit_screen,color: Colors.yellow,), onPressed:(){}),
                ],
              ),
            ),
            Container(
              height: 200,
              width: 300,
              child: Image.file(uploadPostImage,fit: BoxFit.contain,),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(Icons.edit_outlined,color: Colors.yellow,),
                  ),
                  Container(
                    height: 115,
                    width: 5,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 124,
                    width: 325,

                    decoration: BoxDecoration(
                      color: Color(0xffEFF0F6),
                      borderRadius: BorderRadius.all(Radius.circular(16)),

                    ),
                    child : TextField(
                      controller: captionController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon:Icon(Icons.mail_outline ),

                          //    border: UnderlineInputBorder(),
                          labelText: 'Registration no.'),
                    ),

                  ),
                ],
              ),
            ),
            MaterialButton(onPressed: () async{
              Provider.of<FirebaseOperations>(context,listen: false).uploadPostData(captionController.text,{
                'caption' : captionController.text,
                'username' : Provider.of<FirebaseOperations>(context,listen:false).initUserName,
                'useremail' : Provider.of<FirebaseOperations>(context,listen:false).initUserEmail,
                'userimage' : Provider.of<FirebaseOperations>(context,listen:false).initUserImage,
                'useruid' : Provider.of<Authentication>(context,listen: false).userUid,
                'time' : Timestamp.now(),
              }).whenComplete((){
                Navigator.pop(context);
              });
            }, child:Text('SHARE',style: TextStyle(color: Colors.white),),
              color: Colors.blue,

            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(12),

        ),
      );
    });
  }

}
