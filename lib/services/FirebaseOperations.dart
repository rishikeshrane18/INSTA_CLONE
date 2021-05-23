import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photoblogapp/landingPage/landingUtils.dart';
import 'package:provider/provider.dart';

class FirebaseOperations with ChangeNotifier{

  UploadTask imageUploadTask;

  Future uploadUserAvatar(BuildContext context) async{
    Reference imageReference = FirebaseStorage.instance.ref().child(
      'userProfileAvatar/${Provider.of<landingUtils>(context,listen:false).getUserAvatar.path}/${TimeOfDay.now()}'
    );

    imageUploadTask = imageReference.putFile(Provider.of<landingUtils>(context,listen:false).getUserAvatar);
    await imageUploadTask.whenComplete((){
      print('Image Uploaded');
    });
    imageReference.getDownloadURL().then((url){
      Provider.of<landingUtils>(context,listen:false).userAvatarUrl = url.toString();
      notifyListeners();
    });
  }
}
