import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/providers/auth_provider.dart';
import 'package:todo_application/utilities/size_config.dart';
import '../../animations/route_animation.dart';
import '../../utilities/themes.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/loading_widget.dart';
import '../register_page/join_page.dart';

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


  final _formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    sizeConfig().init(context);
    final valid=Provider.of<AuthProvider>(context);
    var theme=Theme.of(context);
    return OverLoading(
        isLoading: valid.isLoading,
        child:Scaffold(
          body:Padding(
            padding:const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height:sizeConfig.screenHeight!*.03 ,),

                  Center(child: CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: Column(
                      children: [

                        SvgPicture.asset("assets/mobile_encryption.svg",height: sizeConfig.screenSizeVertical!*25),

                        SizedBox(height:sizeConfig.screenHeight!*.03 ,),

                        Text("Todo helps you stay organized and perform you tasks much faster",textAlign:TextAlign.center,
                            style:Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontSize:sizeConfig.screenSizeHorizontal!*4
                            )),
                      ],
                    ),
                  )),

                  SizedBox(height:sizeConfig.screenHeight!*.03 ,),

                  /*Start email address form field*/
                  CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: TextFormField(
                      controller: valid.emailController,
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

                  SizedBox(height:sizeConfig.screenHeight!*.03 ,),

                  /*Start password form field*/
                  CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: TextFormField(
                      controller: valid.passwordController,
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

                  SizedBox(height:sizeConfig.screenHeight!*.03 ,),

                  //User password forget widget
                  CustomAnimatedWidget(
                      wSlideDirection: AnimDirection.fromTop,
                      animationController: _rAnimationController!,
                      child: Text('Forget Password?',
                          style:theme.textTheme.bodyText2!.copyWith(
                            fontSize:sizeConfig.screenSizeHorizontal!*3.5,
                              decoration: TextDecoration.underline))),
                  SizedBox(height:sizeConfig.screenHeight!*.05,),

                  //Log-In Button
                  CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: ButtonWidget(
                      onTap:() {
                        valid.LoginValid(context);
                      },
                      radius: 7,
                      color: Theme.of(context).colorScheme.secondary,
                      label:Text("Login".toUpperCase(),style:Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: sizeConfig.screenSizeHorizontal!*4,
                          color:kBgColor),),
                    ),
                  ),

                  SizedBox(height:sizeConfig.screenHeight!*.03),

                  //New user account todos application Sign-Up
                  CustomAnimatedWidget(
                    wSlideDirection: AnimDirection.fromTop,
                    animationController: _rAnimationController!,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("don't have a account?",style:theme.textTheme.bodyText2!.copyWith(
                            fontSize:sizeConfig.screenSizeHorizontal!*4,
                        )),

                        const SizedBox(width:8),

                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(customRoute(const SignUpWithEmail()));
                          },
                          child: Text("Sign Up".toUpperCase(),
                              style:theme.textTheme.bodyText2!.copyWith(
                                fontSize:sizeConfig.screenSizeHorizontal!*3,
                                  decoration: TextDecoration.underline)),
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




