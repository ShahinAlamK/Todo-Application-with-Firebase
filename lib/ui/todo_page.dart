import 'package:flutter/material.dart';
import 'package:todo_application/animations/route_animation.dart';
import 'package:todo_application/ui/create_todo_page.dart';
import 'package:todo_application/ui/profile_page.dart';
import 'package:todo_application/utilities/constant.dart';
import 'package:todo_application/widgets/drawer_widget.dart';
import 'package:todo_application/widgets/search_widget.dart';
import '../animations/listitem_animation.dart';
import '../widgets/line_widget.dart';
import '../widgets/title_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>with TickerProviderStateMixin {


  AnimationController?_animationController;
  AnimationController?_rAnimationController;
  final ScrollController _scrollController=ScrollController();
   bool _isScrolling=true;

  final _statKey=GlobalKey<ScaffoldState>();


  @override
  void initState() {
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
    //final theme=Theme.of(context);
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
                Navigator.of(context).push(customRoute(const ProfilePage()));
              },
              child: Container(
                height: 40,
                width: 40,
                decoration:const BoxDecoration(
                  color:Colors.blueGrey,
                  shape: BoxShape.circle
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

      body:Padding(
        padding:EdgeInsets.symmetric(horizontal: Constant.defaultPadding),
        child: Column(
          children:[

           const SizedBox(height:15),
            const SearchWidget(),

            const SizedBox(height:25),
            const LineWidget(),

            const SizedBox(height:25),

            TodoBuilder(scrollController:_scrollController,),

          ],
        ),
      ),
    );
  }
}

class TodoBuilder extends StatefulWidget {
  final ScrollController scrollController;

  const TodoBuilder({Key? key, required this.scrollController,}) : super(key: key);


  @override
  State<TodoBuilder> createState() => _TodoBuilderState();
}

class _TodoBuilderState extends State<TodoBuilder>with SingleTickerProviderStateMixin {

  AnimationController? _animationController;
  bool isExpanded=false;

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
        itemCount: 30,
        itemBuilder: (_,index){
          return ListAnimation(
            position: index,
              item: 20,
              slideDirection: SlideDirection.fromTop,
              animationController:_animationController!,
              child:TitleWidget(
                onTap: (){},
                longTap:(){bottomSheetModel(context);},
                leading: Container(
                  height: 30,
                  width: 30,
                  decoration:BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.secondary
                  ),
                  child:const Icon(Icons.ac_unit_outlined),
                ),
                trilling:Checkbox(value: true, onChanged:(value){}),

                title:Text("Title Hello Bangladesh People",maxLines: 1,overflow:TextOverflow.ellipsis,style: theme.textTheme.bodyText1,),
                subTitle: Text("category: coding",style: theme.textTheme.bodyText2,),
              ));
        },

    ));
  }
}


