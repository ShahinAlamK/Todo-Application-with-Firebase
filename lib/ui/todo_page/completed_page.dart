import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/utilities/constant.dart';
import 'package:todo_application/views/todo_builder.dart';
import '../../animations/listitem_animation.dart';
import '../../controllers/local_notification.dart';
import '../../providers/task_provider.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/title_widget.dart';
import 'package:timezone/data/latest.dart' as tz;


class CompletedPage extends StatefulWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> with TickerProviderStateMixin{

  AnimationController?_animationController;
  AnimationController?_rAnimationController;
  final ScrollController _scrollController=ScrollController();
  bool _isScrolling=true;

  LocalNotification localNotification=LocalNotification();
  final _statKey=GlobalKey<ScaffoldState>();


  @override
  void initState() {
    localNotification.initialize();
    tz.initializeTimeZones();

    _animationController=AnimationController(vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 1)
    );
    _rAnimationController=AnimationController(vsync: this, duration: const Duration(seconds:1),)..reset();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }


  @override
  void dispose() {
    _animationController!.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener(){
    if(_scrollController.position.pixels<100){
      _animationController!.forward();
      setState(() {
        _isScrolling=true;
      });
    } if(_scrollController.position.pixels>100){
      _animationController!.forward();
      setState(() {
        _isScrolling=false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final task=context.watch<TaskProvider>();
    final theme=Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Todos",style: Theme.of(context).textTheme.headline6,),
      ),
      body:Padding(
        padding:EdgeInsets.symmetric(horizontal:Constant.defaultPadding),
        child:task.completeTodo.isEmpty?const EmptyWidget(massage:"Completed Todo Empty",):
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (_,index){return const SizedBox(height: 15,);},
          itemCount:task.completeTodo.length,
          itemBuilder: (_,index){
            return ListAnimation(
                position: index,
                item:task.completeTodo.length,
                slideDirection: SlideDirection.fromTop,
                animationController:_animationController!,
                child:TitleWidget(
                  onTap: (){},
                  longTap:task.completeTodo[index].isComplete==false?null:(){bottomSheetModel(context,task.completeTodo[index]);},
                  leading: Container(
                    height: 30,
                    width: 30,
                    decoration:BoxDecoration(
                        shape: BoxShape.circle,
                        color:task.completeTodo[index].isComplete==true? Colors.green:theme.colorScheme.secondary
                    ),
                    child:task.completeTodo[index].isComplete==true?const Icon(Icons.done_all):const Icon(Icons.ac_unit_outlined),
                  ),
                  trilling:Checkbox(value:task.completeTodo[index].isComplete!, onChanged:(value){

                    localNotification.notificationSend(task.completeTodo[index].title!,task.completeTodo[index].isComplete==true?"Uncompleted":"Completed");

                    Provider.of<TaskProvider>(context,listen: false)
                        .updateComplete(context: context,
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        isComplete:value!,
                        id:task.completeTodo[index].id
                    );
                  }),

                  title:Text(task.completeTodo[index].title!,maxLines: 1,overflow:TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText1!
                        .copyWith(decoration:task.completeTodo[index].isComplete==true?TextDecoration.lineThrough:TextDecoration.none ),),
                  subTitle: Row(
                    children: [
                      Text("Start: ${task.completeTodo[index].start!}",style: theme.textTheme.bodyText2!.copyWith(decoration:task.completeTodo[index].isComplete==true?TextDecoration.lineThrough:TextDecoration.none ),),
                      const SizedBox(width: 15),
                      Text("End: ${task.completeTodo[index].end!}",style: theme.textTheme.bodyText2!.copyWith(decoration:task.completeTodo[index].isComplete==true?TextDecoration.lineThrough:TextDecoration.none ),),
                    ],
                  ),
                ));
          },

        ),
      )
    );
  }
}
