import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photoblogapp/Homepage/homePage.dart';
import 'package:photoblogapp/landingPage/landingUtils.dart';
import 'package:photoblogapp/services/FirebaseOperations.dart';
import 'package:photoblogapp/services/authentication.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class LandingServices with ChangeNotifier {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  showUserAvatar(BuildContext context){
    return showModalBottomSheet(context: context, builder: (context){
      return Container(

        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width ,
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 15)
              ,),
            Divider(
              thickness: 4.0,
              color: Colors.white,
            ),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.transparent,
              backgroundImage: FileImage(
              Provider.of<landingUtils>(context).userAvatar
              ),
            ),
            Container(
              child: Row(
                children: [
                  MaterialButton(child: Text('RESELECT IMAGE'),onPressed: (){
                    Provider.of<landingUtils>(context).pickUserAvatar(context, ImageSource.gallery);
                  }),
                  MaterialButton(child: Text('CONFIRM IMAGE'),onPressed: (
                      ){
                    Provider.of<FirebaseOperations>(context,listen: false).uploadUserAvatar(context);
                  }),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(15),

        ),
      );
    });
  }


  Widget passwordLessSignIn(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.40,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('allUsers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return new ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                  return ListTile(
                    trailing: IconButton(
                      icon: Icon(
                        EvaIcons.trashOutline,
                        color: Colors.white,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(documentSnapshot['userimage']),
                      //['userimage']
                    ),
                    subtitle: Text(documentSnapshot['useremail']),
                    //['useremail']
                    title: Text(documentSnapshot['username']),
                    // ['username']
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  logInSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  // TextField(
                  //   obscureText: true,
                  //   controller: userNameController,
                  //   decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       prefixIcon: Icon(Icons.remove_red_eye_outlined),
                  //       //border: UnderlineInputBorder(),
                  //       labelText: 'Username',
                  //       suffixIcon: Icon(Icons.clear)),
                  // ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 15)),
                  TextField(
                    //obscureText: true,
                    controller: userEmailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.remove_red_eye_outlined),
                        //border: UnderlineInputBorder(),
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.clear)),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 15)),
                  TextField(
                    obscureText: true,
                    controller: userPasswordController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.remove_red_eye_outlined),
                        //border: UnderlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.clear)),
                  ),
                  new ElevatedButton(
                      onPressed: () {
                        Provider.of<Authentication>(context, listen: false)
                            .createAccount(userEmailController.text,
                                userPasswordController.text)
                            .whenComplete(() {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: HomePage(),
                                  type: PageTransitionType.fade));
                        });
                      },
                      child: Icon(EvaIcons.checkmark)),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
            ),
          );
        });
  }

  signInSheet(BuildContext context) {
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
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 80.0,
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 15)),
                  TextField(
                    //  obscureText: true,
                    controller: userNameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.ac_unit),
                        //border: UnderlineInputBorder(),
                        labelText: 'Username',
                        suffixIcon: Icon(Icons.clear)),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 15)),
                  TextField(
                    //obscureText: false,
                    controller: userEmailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.remove_red_eye_outlined),
                        //border: UnderlineInputBorder(),
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.clear)),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 15)),
                  TextField(
                    obscureText: true,
                    controller: userPasswordController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.remove_red_eye_outlined),
                        //border: UnderlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.clear)),
                  ),
                  new ElevatedButton(
                      onPressed: () {
                        Provider.of<Authentication>(context, listen: false)
                            .logIntoAccount(userEmailController.text,
                                userPasswordController.text)
                            .whenComplete(() {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: HomePage(),
                                  type: PageTransitionType.fade));
                        });
                      },
                      child: Icon(EvaIcons.checkmark)),
                ],
              ),
            ),
          );
        });
  }
}
