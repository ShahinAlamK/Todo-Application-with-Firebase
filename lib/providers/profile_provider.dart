import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'auth_provider.dart';


class ProfileProvider extends ChangeNotifier{

  UserModel get profileData=>_userModel!;
  UserModel? _userModel;

  bool get isLoading=>_isLoading;
  bool _isLoading=false;

  String get error=>_error!;
  String?_error;

  setLoading(bool loading){
    _isLoading=loading;
    notifyListeners();
  }

  setData(UserModel userModel)async{
    _userModel=userModel;
    setLoading(true);
    notifyListeners();
  }

  ProfileProvider(){
    fetchUser();
  }


  fetchUser()async{
    Stream snapshot=profileCollection.doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
    return snapshot.forEach((element) {
      UserModel userModel=UserModel(
        name: element['name'],
        profile: element['profile'],
        email: element['email'],
        uid: element['uid'],
        dateTime:element['create'],
      );
      setData(userModel);
      notifyListeners();
    });
  }

  Future updateProfile(UserModel userModel)async{
    profileCollection.doc(userModel.uid).update({
      "name":userModel.name,
      "profile":userModel.profile
    });
  }

}