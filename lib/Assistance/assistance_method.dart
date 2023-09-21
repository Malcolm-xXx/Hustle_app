import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hustle/Global/global.dart';
import 'package:hustle/Model/user_model.dart';

class AssistanceMethods {
  static void readCurrentOnlineUserInfo() async{
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
    .ref()
    .child('users')
    .child(currentUser!.uid);

    userRef.once().then((snap){
      if (snap.snapshot.value != null){
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }
}