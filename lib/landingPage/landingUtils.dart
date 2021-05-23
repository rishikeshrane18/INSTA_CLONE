import 'dart:io';

import 'package:flutter/cupertino.dart';
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
}
