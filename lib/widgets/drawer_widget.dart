import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/providers/auth_provider.dart';
import 'package:todo_application/providers/task_provider.dart';
import 'package:todo_application/ui/login_page/signin_page.dart';
import 'package:todo_application/utilities/size_config.dart';
import '../animations/route_animation.dart';
import '../controllers/local_notification.dart';
import '../providers/profile_provider.dart';
import '../ui/todo_page/completed_page.dart';
import 'developer_info.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);


  checkImg(String img){
    if(img.isEmpty){
      return SvgPicture.asset("assets/mobile_encryption.svg",fit:BoxFit.cover,);
    }if(img==null){
      return SvgPicture.asset("assets/mobile_encryption.svg");
    }
    return Image.network(img,fit:BoxFit.cover,);
  }

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<ProfileProvider>(context);
    final task=Provider.of<TaskProvider>(context);
    user.fetchUser();
    LocalNotification localNotification=LocalNotification();

    return Drawer(
      elevation:0,
      width: sizeConfig.screenWeight!/1.5,
      child: ListView(
        children: [

          UserAccountsDrawerHeader(
              decoration:BoxDecoration(color:Theme.of(context).scaffoldBackgroundColor),
              currentAccountPicture: Container(
                height: 80,
                width: 80,
                decoration:const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration:const BoxDecoration(
                        color:Colors.blueGrey,
                        shape: BoxShape.circle
                    ),
                    child: user.isLoading?checkImg(user.profileData.profile!):SizedBox(),
                  ),
                ),
              ),
              accountName:Text(user.isLoading?user.profileData.name!:"",
                style:Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: sizeConfig.screenSizeHorizontal!*4
              ),),

              accountEmail: Text(user.isLoading?user.profileData.email!:"",
                style:Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: sizeConfig.screenSizeHorizontal!*3),
              )),

           ListTile(
            onTap:(){
              Navigator.pop(context);
              Navigator.of(context).push(customRoute(const CompletedPage()));
            },
             trailing: Text("${task.isLoading?0:task.completeTodo.length.toString()}"),
            leading: const Icon(Icons.done_all),
            title:Text("Complete Task",style:Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: sizeConfig.screenSizeHorizontal!*4
            ),),
          ),

           ListTile(
            onTap:(){
              Navigator.pop(context);
              localNotification.notificationSend("Settings","Coming Soon");
            },
            leading: const Icon(Icons.settings),
            title:Text("Settings",style:Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: sizeConfig.screenSizeHorizontal!*4
            ),),
          ),

           ListTile(
            onTap:(){
              Navigator.pop(context);
              showDialog(context: context, builder:(_){
                return const DeveloperInfoDialog();
              });
            },
            leading: const Icon(Icons.device_hub),
            title:Text("Developer",style:Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: sizeConfig.screenSizeHorizontal!*4
            ),),
          ),

           ListTile(
            leading: const Icon(Icons.delete),
            title:Text("Delete Account",style:Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: sizeConfig.screenSizeHorizontal!*4
            ),),

            onTap: (){
              Navigator.pop(context);
              Provider.of<AuthProvider>(context,listen: false).deleteAccount(context,FirebaseAuth.instance.currentUser!).whenComplete((){
                Navigator.of(context).pushAndRemoveUntil(customRoute(SignWithEmail()), (route) => false);
              }
              );},
          ),

           ListTile(
            leading: const Icon(Icons.exit_to_app),
            title:Text("Log Out",style:Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: sizeConfig.screenSizeHorizontal!*4
            ),),

            onTap: (){
              Provider.of<AuthProvider>(context,listen: false).signOut().whenComplete(() =>

              Navigator.of(context).pushAndRemoveUntil(customRoute(SignWithEmail()), (route) => false));
            },
          ),
        ],
      ),
    );
  }
}


