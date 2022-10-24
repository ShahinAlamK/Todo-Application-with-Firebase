import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/animations/route_animation.dart';
import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/ui/create_todo_page.dart';
import 'package:todo_application/ui/profile_page.dart';
import 'package:todo_application/utilities/constant.dart';
import 'package:todo_application/utilities/size_config.dart';
import 'package:todo_application/widgets/drawer_widget.dart';
import 'package:todo_application/widgets/search_widget.dart';
import '../controllers/local_notification.dart';
import '../providers/profile_provider.dart';
import '../providers/task_provider.dart';
import '../views/todo_builder.dart';
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

    } if(_scrollController.position.pixels>100){
      _animationController!.forward(); 
    }
  }

  String? _searchController='';
  List<TodoModel>searchResult(String query){
    List<TodoModel>result=Provider.of<TaskProvider>(context).taskList.where((element){
      return element.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return result;
  }

  CheckImage(String image){
      if(image.isEmpty){
        return AssetImage("");
      }else{
        return NetworkImage(image);
      }
}

  @override
  Widget build(BuildContext context) {
    sizeConfig().init(context);
    TaskProvider taskProvider=context.watch<TaskProvider>();
    final user=Provider.of<ProfileProvider>(context);
    user.fetchUser();

    final task=Provider.of<TaskProvider>(context,listen: false);
    task.fetchTask(uid:widget.uid);

    List<TodoModel>todoSearch=searchResult(_searchController!);


    return  Scaffold(
      key: _statKey,

      appBar: AppBar(
        centerTitle: true,
        leading:IconButton(onPressed:(){
          _statKey.currentState!.openDrawer();
        }, icon:const Icon(Icons.menu)),

        title:Text("Today Todo"),

        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(customRoute(ProfilePage(
                username: user.profileData.name!,
                profile: user.profileData.profile!,
                uid: user.profileData.uid!,)));
            },
            child:user.isLoading?CircleAvatar(
              maxRadius: 16,
              backgroundColor:Colors.green,
              backgroundImage:CheckImage(user.profileData.profile!),
            ):SizedBox(),
          ),
          SizedBox(width:sizeConfig.weight!*.05)
        ],
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
             SizedBox(height:sizeConfig.height!*.02),
              SearchWidget(valueChanged: (value) {
                setState(() {
                  _searchController=value;
                });
              },),
              SizedBox(height:sizeConfig.height!*.03),
              const LineWidget(),
              SizedBox(height:sizeConfig.height!*.03),
              ui(taskProvider,todoSearch),

            ],
          ),
        ),
      ),
    );
  }

  ui(TaskProvider taskProvider,query){
    if(taskProvider.isLoading){
      return Center(child: CircularProgressIndicator());
    }
    if(taskProvider.taskList.isEmpty){
      return  SvgPicture.asset("assets/undraw_personal_file.svg",height:200,);
    }if(query.length==0){
      return  SvgPicture.asset("assets/undraw_personal_file.svg",height: 200,);
    }else{
      return TodoBuilder(scrollController:_scrollController,todoList:query);
    }
  }
}








