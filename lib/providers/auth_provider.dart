import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/widgets/senckbar_widget.dart';
import '../animations/route_animation.dart';
import '../ui/todo_page/todo_page.dart';



FirebaseFirestore fireStore=FirebaseFirestore.instance;
CollectionReference profileCollection=fireStore.collection("users");
CollectionReference taskCollection=profileCollection;

class AuthProvider extends ChangeNotifier{


  bool isLoading=false;
  TextEditingController userController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  LoginValid(BuildContext context){
    if(emailController.text.isEmpty && passwordController.text.isEmpty){
      messageSnack(context,Colors.red, "Please valid your email passwords");
    }else{
      isLoading=true;
      signInAuth(context).whenComplete((){
        isLoading=false;
      });
      notifyListeners();
    }
  }

  joinValid(BuildContext context){
    if(emailController.text.isEmpty && passwordController.text.isEmpty && userController.text.isEmpty){
      messageSnack(context,Colors.red, "Please valid your email passwords");
    }else{
      isLoading=true;
      signUpWithEmail(context).whenComplete((){
        isLoading=false;
      });
      notifyListeners();
    }
  }

  Future signInAuth(BuildContext context)async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
      .then((value){
        if(value.user!=null){
          Navigator.of(context).pushAndRemoveUntil(customRoute(TodoPage(uid: value.user!.uid)), (route) => false);
        }
      });

    }on FirebaseException catch(e){
      if (e.code == 'user-not-found') {
       messageSnack(context,Colors.redAccent,'No user found for that email.');
      }if (e.code == 'wrong-password') {
        messageSnack(context,Colors.redAccent,'Sorry wrong password');
      }
      isLoading=false;
    }
    notifyListeners();
  }

  Future signUpWithEmail(context)async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text).then((value) {
        if (value.user != null) {
          profileCollection.doc(value.user!.uid).set({
            "uid": value.user!.uid,
            "name": userController.text,
            "email": emailController.text,
            "profile": "",
            "create": DateTime.now().millisecondsSinceEpoch,
          });
          Navigator.of(context).pushAndRemoveUntil(customRoute(TodoPage(uid: value.user!.uid)), (route) => false);
        }
      });
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        messageSnack(context, Colors.redAccent,'The password provided is too weak.');

      }  if (e.code == 'email-already-in-use') {
        messageSnack(context, Colors.redAccent,'The account already exists for that email.');
      }
    }
    notifyListeners();
  }

  Future deleteAccount(BuildContext context,User user)async{
    try{
      await user.delete().whenComplete((){
         messageSnack(context,Colors.red,"Deleted Accounts");
      });
    }catch(er){
print(er);
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
