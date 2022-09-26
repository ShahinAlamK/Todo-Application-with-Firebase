import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/animations/route_animation.dart';
import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/ui/create_todo_page.dart';
import 'package:todo_application/ui/profile_page.dart';
import 'package:todo_application/utilities/constant.dart';
import 'package:todo_application/widgets/drawer_widget.dart';
import 'package:todo_application/widgets/search_widget.dart';
import '../controllers/local_notification.dart';
import '../providers/profile_provider.dart';
import '../providers/task_provider.dart';
import '../views/todo_builder.dart';
import '../widgets/empty_widget.dart';
import '../widgets/line_widget.dart';
import 'package:timezone/data/latest.dart' as tz;


class TodoPage extends StatefulWidget {
  const TodoPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>with TickerProviderStateMixin {


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


  String? _searchController='';
  List<TodoModel>searchResult(String query){
    List<TodoModel>result=Provider.of<TaskProvider>(context).taskList.where((element){
      return element.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return result;
  }



  @override
  Widget build(BuildContext context) {

    TaskProvider taskProvider=context.watch<TaskProvider>();
    final user=Provider.of<ProfileProvider>(context);
    user.fetchUser();

    final task=Provider.of<TaskProvider>(context,listen: false);
    task.fetchTask(uid:widget.uid);

    List<TodoModel>todoSearch=searchResult(_searchController!);


    return  Scaffold(
      key: _statKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: Constant.defaultPadding,),
            IconButton(onPressed:(){
              _statKey.currentState!.openDrawer();
            }, icon:const Icon(Icons.menu)),
            const Spacer(),

            GestureDetector(
              onTap: (){
                Navigator.of(context).push(customRoute(ProfilePage(
                  username: user.profileData.name!,
                  profile: user.profileData.profile!,
                  uid: user.profileData.uid!,)));
              },
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
           SizedBox(width: Constant.defaultPadding,)

          ],
        ),
      ),

      drawer:const DrawerWidget(),
      

      floatingActionButton:CustomAnimatedWidget(
        animationController: _rAnimationController!,
        wSlideDirection:AnimDirection.fromBottom,
        child: FloatingActionButton(
          onPressed:(){Navigator.of(context).push(customRoute(const CreateTodoPage()));},
          mini: true,
          child: const Icon(Icons.add),),
      ),

      body:SafeArea(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: Constant.defaultPadding),
          child: Column(
            children:[

             const SizedBox(height:15),
              SearchWidget(valueChanged: (value) {
                setState(() {
                  _searchController=value;
                });
              },),

              const SizedBox(height:25),
              const LineWidget(),

              const SizedBox(height:25),

              ui(taskProvider,todoSearch),

            ],
          ),
        ),
      ),
    );
  }

  ui(TaskProvider taskProvider,query){

    if(taskProvider.isLoading){
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }
    if(taskProvider.taskList.isEmpty){
      return const EmptyWidget(massage:"Uncompleted Todo",);
    }else{
      return TodoBuilder(scrollController:_scrollController,todoList:query);
    }
  }
}








