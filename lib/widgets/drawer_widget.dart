import 'package:flutter/material.dart';
import 'package:todo_application/models/developer_model.dart';

import '../controllers/local_notification.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    LocalNotification localNotification=LocalNotification();
    //final size=MediaQuery.of(context).size;

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
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:NetworkImage(""))
                ),
              ),
              accountName:Text("Shahin Alam Kiron",style: Theme.of(context).textTheme.bodyText1), accountEmail: Text("kerons89@gamil.com",style: Theme.of(context).textTheme.bodyText2)),

           ListTile(
            onTap:(){
              Navigator.pop(context);
            },
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
                return DeveloperInfoDialog();
              });
            },
            leading: const Icon(Icons.device_hub),
            title: const Text("Developer"),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Log Out"),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}

class DeveloperInfoDialog extends StatelessWidget {
  const DeveloperInfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 55),
      child: Container(
        height:250,
        decoration:BoxDecoration(
          color:theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -50,
                child:CircleAvatar(radius: 40,backgroundColor: theme.colorScheme.secondary,backgroundImage: NetworkImage(developer.pic!),)),

            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height:35),
                  Center(child: Text(developer.name!,style: theme.textTheme.bodyText1,)),
                  const SizedBox(height:25),
                  Text("Email : ${developer.email}",style: theme.textTheme.bodyText2,),
                  const SizedBox(height: 6,),
                  Text("professional : ${developer.professional}",style: theme.textTheme.bodyText2,),
                  const SizedBox(height:6),
                  Text("Address : ${developer.address}",style: theme.textTheme.bodyText2,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
