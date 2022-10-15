import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/ui/details_page.dart';
import '../animations/listitem_animation.dart';
import '../animations/route_animation.dart';
import '../controllers/local_notification.dart';
import '../models/todo_model.dart';
import '../providers/task_provider.dart';
import '../widgets/title_widget.dart';


class TodoBuilder extends StatefulWidget {
  final ScrollController scrollController;
  final List<TodoModel> todoList;

  const TodoBuilder({Key? key, required this.scrollController, required this.todoList,}) : super(key: key);


  @override
  State<TodoBuilder> createState() => _TodoBuilderState();
}

class _TodoBuilderState extends State<TodoBuilder>with SingleTickerProviderStateMixin {

  AnimationController? _animationController;
  bool isExpanded=false;
  LocalNotification localNotification=LocalNotification();

  @override
  void initState() {
    _animationController=AnimationController(vsync: this,duration: const Duration(seconds: 2));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Expanded(child: ListView.separated(
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (_,index){return const SizedBox(height: 15,);},
      itemCount:widget.todoList.length,
      itemBuilder: (_,index){
        return ListAnimation(
            position: index,
            item: widget.todoList.length,
            slideDirection: SlideDirection.fromTop,
            animationController:_animationController!,
            child:TitleWidget(
              onTap: (){
                Navigator.of(context).push(customRoute(DetailsPage(todoModel: widget.todoList[index],)));
              },
              longTap:widget.todoList[index].isComplete==false?null:(){bottomSheetModel(context,widget.todoList[index]);},
              leading: Container(
                height: 30,
                width: 30,
                decoration:BoxDecoration(
                    shape: BoxShape.circle,
                    color:widget.todoList[index].isComplete==true? Colors.green:theme.colorScheme.secondary
                ),
                child:widget.todoList[index].isComplete==true?const Icon(Icons.done_all):const Icon(Icons.ac_unit_outlined),
              ),
              trilling:Checkbox(value: widget.todoList[index].isComplete!, onChanged:(value){

                localNotification.notificationSend(widget.todoList[index].title!,widget.todoList[index].isComplete==true?"Uncompleted":"Completed");

                Provider.of<TaskProvider>(context,listen: false)
                    .updateComplete(context: context,
                    uid: FirebaseAuth.instance.currentUser!.uid,
                    isComplete:value!,
                    id: widget.todoList[index].id
                );
              }),

              title:Text(widget.todoList[index].title!,maxLines: 1,overflow:TextOverflow.ellipsis,
                style: theme.textTheme.bodyText1!
                    .copyWith(decoration:widget.todoList[index].isComplete==true?TextDecoration.lineThrough:TextDecoration.none ),),
              subTitle: Row(
                children: [
                  Text("Start: ${widget.todoList[index].start!}",style: theme.textTheme.bodyText2!.copyWith(decoration:widget.todoList[index].isComplete==true?TextDecoration.lineThrough:TextDecoration.none ),),
                  const SizedBox(width: 15),
                  Text("End: ${widget.todoList[index].end!}",style: theme.textTheme.bodyText2!.copyWith(decoration:widget.todoList[index].isComplete==true?TextDecoration.lineThrough:TextDecoration.none ),),
                ],
              ),
            ));
      },

    ));
  }

}
