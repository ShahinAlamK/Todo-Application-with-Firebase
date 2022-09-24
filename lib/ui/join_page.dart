import 'package:flutter/material.dart';

import '../utilities/themes.dart';
import '../widgets/button_widget.dart';
import '../widgets/senckbar_widget.dart';



class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({Key? key}) : super(key: key);

  @override
  State<SignUpWithEmail> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {

  bool isLoading=false;
  final _formKey=GlobalKey<FormState>();
  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();


  formValidity()async{
    if(_formKey.currentState!.validate()){
      var theme=Theme.of(context);
      if(_emailController.text.isEmpty ||_passwordController.text.isEmpty){
        messageSnack(context,theme.errorColor,"Invalid FormField");
      }
      else{

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body:Padding(
        padding:const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height:size.height*.04),

              Center(child: Column(
                    children: [
                      Text("Welcome to",textAlign:TextAlign.center, style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 35)),
                      const SizedBox(height: 10,),
                      Text("Todo helps you stay organized and perform you tasks much faster",textAlign:TextAlign.center,
                          style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:14)),
                    ],
                  )
              ),

              SizedBox(height:size.height*.12,),


              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                    hintText: "Username",
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    border: InputBorder.none
                ),
              ),
              SizedBox(height:size.height*.03 ,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Enter Email",
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    border: InputBorder.none
                ),
              ),
              SizedBox(height:size.height*.03 ,),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    prefixIcon: const Icon(Icons.lock),
                    filled: true,
                    border: InputBorder.none
                ),
              ),
              SizedBox(height:size.height*.05,),

              //SignUp Button
              ButtonWidget(
                onTap:() {
                  formValidity();
                },
                radius: 7,
                color: Theme.of(context).colorScheme.secondary,
                label:Text("Create".toUpperCase(),style:Theme.of(context).textTheme.headline6!.copyWith(color:kBgColor),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

bottomSnack(BuildContext context,Color bg,String title)async{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
              color:bg,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline),
              SizedBox(width: 10,),
              Text(title),
            ],
          ))));
}
