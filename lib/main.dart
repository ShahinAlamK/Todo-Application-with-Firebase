import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_application/ui/signin_page.dart';
import 'package:todo_application/utilities/themes.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(CustomTheme.systemUiOverlayStyle);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Application',
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const SignWithEmail()
    );
  }
}

