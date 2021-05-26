import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photoblogapp/landingPage/landingServices.dart';
import 'package:photoblogapp/services/FirebaseOperations.dart';
import 'package:provider/provider.dart';

class landingUtils with ChangeNotifier {
  final picker = ImagePicker();
  File userAvatar;

  File get getUserAvatar => userAvatar;
  String userAvatarUrl;

  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    // File _image;
    //  bool _isImageThere = false;
    var pickedUserAvatar = await picker.getImage(source: source);
    print('hello1');

    pickedUserAvatar == null
        ? print('Select Image')
        : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    userAvatar != null
        ? Provider.of<LandingServices>(context, listen: false)
            .showUserAvatar(context)
        : print('Image Upload error');

    notifyListeners();
  }

  Future selectAvatarOptionsSheet(BuildContext context) async{
    return  showModalBottomSheet(context: context, builder : (context){
      return Container(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15)
              ,),
            Divider(
              thickness: 4.0,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(child: Text('Gallery'),onPressed:(){
                  pickUserAvatar(context, ImageSource.gallery).whenComplete((){
                    Navigator.pop(context);
                    Provider.of<LandingServices>(context,listen: false).showUserAvatar(context);
                  });
                }),
                MaterialButton(child: Text('Camera'),onPressed:(){
                  pickUserAvatar(context, ImageSource.camera).whenComplete((){
                    Navigator.pop(context);
                    Provider.of<LandingServices>(context,listen: false).showUserAvatar(context);
                  });
                })
              ],
            )
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(15),
        ),
      );
    });

  }

}
