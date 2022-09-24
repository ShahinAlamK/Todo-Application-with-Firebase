
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_application/utilities/constant.dart';
import 'package:todo_application/utilities/fonts.dart';

const Color kBgColor=Color(0xff0D2237);
const Color kTextColor=Color(0xffE0EAF4);
const Color kButtonColor=Color(0xffFF8E2B);
const Color kErrorColor=Color(0xffd0243c);



class CustomTheme{

 static SystemUiOverlayStyle systemUiOverlayStyle=const SystemUiOverlayStyle(
     statusBarColor: Colors.transparent,
     systemNavigationBarIconBrightness:Brightness.light,
     systemNavigationBarColor:kBgColor);

  static ThemeData darkTheme=ThemeData.dark().copyWith(
    scaffoldBackgroundColor: kBgColor,
    brightness: Brightness.dark,

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: kTextColor,
      selectionColor: kButtonColor
    ),
    
    dialogTheme: DialogTheme(
      backgroundColor:kBgColor,
      elevation:3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
    ),
    
    dataTableTheme: DataTableThemeData(
      headingRowColor:MaterialStateProperty.all(Colors.cyan),
      dataRowColor: MaterialStateProperty.all(Colors.cyan),
    ),

    colorScheme:const ColorScheme.dark(
      brightness: Brightness.dark,
      secondary: kButtonColor,
      error: kErrorColor,
    ),
    errorColor: kErrorColor,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        backgroundColor: MaterialStateProperty.all(kButtonColor),
        textStyle: MaterialStateProperty.all(CustomFontStyle.bodyFonts.copyWith(color:kTextColor)),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: Constant.defaultPadding))
      )
    ),
    appBarTheme: const AppBarTheme(
      titleSpacing: 0,
     centerTitle: false,
     elevation: 0,
     scrolledUnderElevation: 0,
     backgroundColor: kBgColor,
    ),
    drawerTheme:const DrawerThemeData(
      backgroundColor: kBgColor,
      elevation: 1
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: kButtonColor,
      linearMinHeight: 1
    ),
    textTheme: TextTheme(
      headline6: CustomFontStyle.headingFonts,
      bodyText1: CustomFontStyle.bodyFonts,
      bodyText2: CustomFontStyle.bodyFonts1
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: CustomFontStyle.bodyFonts1,
      border: InputBorder.none,
      prefixIconColor:kButtonColor,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor:MaterialStateProperty.all(kBgColor),
      fillColor:MaterialStateProperty.all(kButtonColor),
    ),
    iconTheme:const IconThemeData(color: kTextColor)
  );
}