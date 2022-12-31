import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/utilities/size_config.dart';
import 'package:todo_application/widgets/loading_widget.dart';
import '../../providers/auth_provider.dart';
import '../../utilities/themes.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/senckbar_widget.dart';



class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({Key? key}) : super(key: key);

  @override
  State<SignUpWithEmail> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {

  final _formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    final provider=Provider.of<AuthProvider>(context);

    return OverLoading(
      isLoading:provider.isLoading,
      child: Scaffold(
        body:Padding(
          padding:const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: ListView(
              physics:BouncingScrollPhysics(),
              children: [
                SizedBox(height:sizeConfig.screenHeight!*.03),

                SvgPicture.asset("assets/mobile_encryption.svg",height: sizeConfig.screenSizeVertical!*25),

                SizedBox(height:sizeConfig.screenHeight!*.03),

                Text("Todo helps you stay organized and perform you tasks much faster",textAlign:TextAlign.center,
                    style:Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize:sizeConfig.screenSizeHorizontal!*4
                    )),

                SizedBox(height:sizeConfig.screenHeight!*.03),


                TextFormField(
                  controller: provider.userController,
                  decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: const Icon(Icons.person),
                      filled: true,
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      border: InputBorder.none
                  ),
                ),

                SizedBox(height:sizeConfig.screenHeight!*.03),

                TextFormField(
                  controller: provider.emailController,
                  keyboardType:TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Enter Email",
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      border: InputBorder.none
                  ),
                ),

                SizedBox(height:sizeConfig.screenHeight!*.03),

                TextFormField(
                  controller: provider.passwordController,
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      prefixIcon: const Icon(Icons.lock),
                      filled: true,
                      border: InputBorder.none
                  ),
                ),

                SizedBox(height:sizeConfig.screenHeight!*.03),

                //SignUp Button
                ButtonWidget(
                  onTap:() {
                    provider.joinValid(context);
                  },
                  radius: 7,
                  color: Theme.of(context).colorScheme.secondary,
                  label:Text("Create".toUpperCase(),
                    style:Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: sizeConfig.screenSizeHorizontal!*4,
                        color:kBgColor
                    ),),
                ),
                SizedBox(height:sizeConfig.screenHeight!*.03),

              ],
            ),
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
