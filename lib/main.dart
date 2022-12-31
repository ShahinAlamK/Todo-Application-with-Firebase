import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/providers/auth_provider.dart';
import 'package:todo_application/providers/create_todo_provider.dart';
import 'package:todo_application/providers/profile_provider.dart';
import 'package:todo_application/providers/task_provider.dart';
import 'package:todo_application/ui/login_page/signin_page.dart';
import 'package:todo_application/utilities/themes.dart';

import 'ui/todo_page/todo_page.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(CustomTheme.systemUiOverlayStyle);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget authChange() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return TodoPage(uid: snapshot.data!.uid);
          }if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return const SignWithEmail();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create:(_)=>AuthProvider()),
        ChangeNotifierProvider<ProfileProvider>(create:(_)=>ProfileProvider()),
        ChangeNotifierProvider<TaskProvider>(create:(_)=>TaskProvider()),
        ChangeNotifierProvider<CreateTodoProvider>(create:(_)=>CreateTodoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo Application',
        darkTheme: CustomTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: authChange()
      ),
    );
  }
}

