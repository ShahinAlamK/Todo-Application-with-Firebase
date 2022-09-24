import 'package:flutter/material.dart';
import 'package:todo_application/ui/todo_page.dart';
import '../animations/route_animation.dart';
import '../utilities/themes.dart';
import '../widgets/button_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/senckbar_widget.dart';
import 'join_page.dart';

class SignWithEmail extends StatefulWidget {
  const SignWithEmail({Key? key}) : super(key: key);

  @override
  State<SignWithEmail> createState() => _SignWithEmailState();
}

class _SignWithEmailState extends State<SignWithEmail>with SingleTickerProviderStateMixin {


  AnimationController?_rAnimationController;
  @override
  void initState() {
    _rAnimationController=AnimationController(vsync: this, duration: const Duration(seconds:1),);
    super.initState();
  }


  bool isLoading=false;
  final _formKey=GlobalKey<FormState>();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();


  formValidity()async{
    var theme=Theme.of(context);
    if(_formKey.currentState!.validate()){
      if(_emailController.text.isEmpty ||_passwordController.text.isEmpty){
       messageSnack(context,theme.errorColor,"Invalid FormField");
      }
      else{
        setState(()=>isLoading=true);
        await Future.delayed(const Duration(seconds: 3));
        Navigator.of(context).push(customRoute(const TodoPage()));
        setState(()=>isLoading=false);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    var theme=Theme.of(context);
    return OverLoading(
        isLoading: isLoading,
        child:Scaffold(
          body:Padding(
            padding:const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height:size.height*.07),

                  Center(child: CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: Column(
                      children: [
                        Text("Welcome to",textAlign:TextAlign.center, style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 35)),
                        const SizedBox(height: 10,),
                        Text("Todo helps you stay organized and perform you tasks much faster",textAlign:TextAlign.center,
                            style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:14)),
                      ],
                    ),
                  )),

                  SizedBox(height:size.height*.12,),

                  /*Start email address form field*/
                  CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Enter Email",
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          prefixIcon: const Icon(Icons.email),
                          filled: true,
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  /*End email address form field*/

                  SizedBox(height:size.height*.03 ,),

                  /*Start password form field*/
                  CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          filled: true,
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  /*End password form field*/

                  SizedBox(height:size.height*.03 ,),

                  //User password forget widget
                  CustomAnimatedWidget(
                      wSlideDirection: AnimDirection.fromTop,
                      animationController: _rAnimationController!,
                      child: Text('Forget Password?',style:theme.textTheme.bodyText2!.copyWith(decoration: TextDecoration.underline))),
                  SizedBox(height:size.height*.05,),

                  //Log-In Button
                  CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: ButtonWidget(
                      onTap:() {
                        formValidity();
                      },
                      radius: 7,
                      color: Theme.of(context).colorScheme.secondary,
                      label:Text("Login".toUpperCase(),style:Theme.of(context).textTheme.headline6!.copyWith(color:kBgColor),),
                    ),
                  ),

                  SizedBox(height:size.height*.05,),

                  //New user account todos application Sign-Up
                  CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("don't have a account?"),
                        const SizedBox(width:8),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(customRoute(const SignUpWithEmail()));
                          },
                          child: Text("Sign Up".toUpperCase(),
                              style:theme.textTheme.bodyText2!.copyWith(decoration: TextDecoration.underline)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
       );
  }
}




