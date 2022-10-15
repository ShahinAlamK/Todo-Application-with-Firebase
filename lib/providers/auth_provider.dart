import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/widgets/senckbar_widget.dart';
import '../animations/route_animation.dart';
import '../ui/todo_page.dart';



FirebaseFirestore fireStore=FirebaseFirestore.instance;
CollectionReference profileCollection=fireStore.collection("users");
CollectionReference taskCollection=profileCollection;

class AuthProvider extends ChangeNotifier{


  Future signInAuth(BuildContext context, email, password)async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
      .then((value){
        if(value.user!=null){
          Navigator.of(context).push(customRoute(TodoPage(uid: value.user!.uid,)));
        }
      });

    }on FirebaseException catch(e){
      if (e.code == 'user-not-found') {
       messageSnack(context,Colors.redAccent,'No user found for that email.');
      }if (e.code == 'wrong-password') {
        messageSnack(context,Colors.redAccent,'Sorry wrong password');
      }
    }
  }


  Future signUpWithEmail(context,String email,password,username)async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password).then((value) {
        if (value.user != null) {
          profileCollection.doc(value.user!.uid).set({
            "uid": FirebaseAuth.instance.currentUser!.uid,
            "name": username,
            "email": email,
            "profile": "",
            "create": DateTime
                .now()
                .millisecondsSinceEpoch,
          });
          Navigator.of(context).pushReplacement(customRoute(TodoPage(uid: value.user!.uid,)));
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        messageSnack(context, Colors.redAccent,'The password provided is too weak.');

      }  if (e.code == 'email-already-in-use') {
        messageSnack(context, Colors.redAccent,'The account already exists for that email.');
      }
    }
  }


  Future signOut()async{
    try{
    return await FirebaseAuth.instance.signOut();
    }on FirebaseException catch(e){
      print(e);
    }
  }

}
