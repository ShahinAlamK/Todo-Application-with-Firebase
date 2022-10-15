import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/widgets/senckbar_widget.dart';

import '../models/todo_model.dart';
import '../providers/task_provider.dart';


class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, this.title, this.subTitle, this.leading, this.trilling, this.onTap, this.longTap,}) : super(key: key);
  final Widget?title,subTitle,leading,trilling;
  final VoidCallback? onTap,longTap;

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return ClipRRect(
      borderRadius:BorderRadius.circular(10),
      child: Material(
        color:theme.scaffoldBackgroundColor,
        child: InkWell(
          onTap: ()=>onTap!(),
          onLongPress: ()=>longTap!(),
          child:Container(
            //height: 60,
            padding: const EdgeInsets.symmetric(vertical: 6),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(.05),
                  blurRadius: 1,
                  spreadRadius:2,
                )
              ]
            ),

            child: Row(
              children: [
                const SizedBox(width: 10),
                leading!=null?leading!:Container(),
                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title!=null?title!:Container(),
                      const SizedBox(height:5),
                      subTitle!=null?subTitle!:Container()
                    ],
                  ),
                ),
                trilling!=null?trilling!:Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bottomSheetModel(BuildContext context,TodoModel todoModel)async{
  showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context, builder:(_){
    return Wrap(
      children: [
        ListTile(
          onTap: (){
            Provider.of<TaskProvider>(context,listen: false)
                .deleteTask(context: context,id:todoModel.id!, uid:FirebaseAuth.instance.currentUser!.uid);
            //messageSnack(context,Theme.of(context).errorColor,"Deleted Todo");
            Navigator.pop(context);
          },
          leading: const Icon(Icons.delete),
          title: const Text("Delete Task"),),
      ],
    );
  });
}

