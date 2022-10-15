import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/providers/auth_provider.dart';
import 'package:todo_application/providers/task_provider.dart';
import 'package:todo_application/ui/completed_page.dart';
import 'package:todo_application/ui/signin_page.dart';
import '../animations/route_animation.dart';
import '../controllers/local_notification.dart';
import '../providers/profile_provider.dart';
import 'developer_info.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user=Provider.of<ProfileProvider>(context);
    final task=Provider.of<TaskProvider>(context);
    user.fetchUser();
    LocalNotification localNotification=LocalNotification();

    return Drawer(
      elevation:0,
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
                    child: user.isLoading?Image.network(user.profileData.profile!,fit: BoxFit.cover,):SvgPicture.asset(""),
                  ),
                ),
              ),
              accountName:Text(user.isLoading?user.profileData.name!:"",style: Theme.of(context).textTheme.bodyText1),
              accountEmail: Text(user.isLoading?user.profileData.email!:"",style: Theme.of(context).textTheme.bodyText2)),

           ListTile(
            onTap:(){
              Navigator.pop(context);
              Navigator.of(context).push(customRoute(const CompletedPage()));
            },
             trailing: Text("${task.isLoading?0:task.completeTodo.length.toString()}"),
            leading: const Icon(Icons.done_all),
            title: const Text("Complete Task"),
          ),
           ListTile(
            onTap:(){
              Navigator.pop(context);
              localNotification.notificationSend("Settings","Coming Soon");
            },
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
          ),
           ListTile(
            onTap:(){
              Navigator.pop(context);
              showDialog(context: context, builder:(_){
                return const DeveloperInfoDialog();
              });
            },
            leading: const Icon(Icons.device_hub),
            title: const Text("Developer"),
          ),
           ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Log Out"),
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


