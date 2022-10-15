import 'package:shared_preferences/shared_preferences.dart';

class StoreToken{

  final String _token="STORTOKEN";
  SharedPreferences? sharedPreferences;


  Future setToken(String?token)async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setString(_token, token!);
  }

  Future loadToken()async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.getString(_token);
  }


}