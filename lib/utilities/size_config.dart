import 'package:flutter/cupertino.dart';

class sizeConfig{
  MediaQueryData? _mediaQueryData;
  static double? screenHeight;
  static double? screenWeight;
  static double? screenSizeHorizontal;
  static double? screenSizeVertical;

  void init(BuildContext context){
    _mediaQueryData=MediaQuery.of(context);
    screenHeight=_mediaQueryData!.size.height;
    screenWeight=_mediaQueryData!.size.width;
    screenSizeHorizontal=screenWeight!/100;
    screenSizeVertical=screenHeight!/100;
  }
}