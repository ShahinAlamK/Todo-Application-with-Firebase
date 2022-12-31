import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/utilities/size_config.dart';
import '../providers/task_provider.dart';


class LineWidget extends StatelessWidget {
  const LineWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final task=Provider.of<TaskProvider>(context);
    task.fetchTask(uid:FirebaseAuth.instance.currentUser!.uid);

    final theme=Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        Text("All Todo",style:theme.textTheme.headline6!.copyWith(fontSize:sizeConfig.screenSizeHorizontal!*4),),
        Text("Total todo :  ${task.isLoading?0:task.taskList.length}",
          style:theme.textTheme.bodyText2!.copyWith(fontSize:sizeConfig.screenSizeHorizontal!*3),)
      ],
    );
  }
}