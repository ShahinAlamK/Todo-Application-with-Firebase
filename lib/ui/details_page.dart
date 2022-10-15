import 'package:flutter/material.dart';
import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/utilities/constant.dart';



class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.todoModel}) : super(key: key);

  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        title:const Text("Details"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constant.defaultPadding,vertical:  Constant.defaultPadding),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Constant.defaultPadding),
              height: size.height*.07,
              width: size.width,
              decoration: BoxDecoration(
                color:Colors.blueGrey.withOpacity(.2),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                children: [
                  Text(todoModel.title!,style: Theme.of(context).textTheme.headline6,)
                ],
              ),
            ),
            const SizedBox(height: 15),

            Container(
              padding: EdgeInsets.symmetric(horizontal: Constant.defaultPadding,vertical: Constant.defaultPadding),
              //height: size.height*.2,
              width: size.width,
              decoration: BoxDecoration(
                  color:Colors.blueGrey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todoModel.description!,style: Theme.of(context).textTheme.headline6,),
                  const SizedBox(height: 15,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics:const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        Text(" Complete : ${todoModel.isComplete.toString()},",style: Theme.of(context).textTheme.bodyText2,),
                        const SizedBox(width:5,),
                        Text("Start : ${todoModel.start!},",style: Theme.of(context).textTheme.bodyText2,),
                        const SizedBox(width:5,),
                        Text("End : ${todoModel.end!}",style: Theme.of(context).textTheme.bodyText2,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            Container(
              padding: EdgeInsets.symmetric(horizontal: Constant.defaultPadding),
              height: size.height*.07,
              width: size.width,
              decoration: BoxDecoration(
                  color:Colors.blueGrey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(5)
              ),
              child:SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics:const BouncingScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Create todo : ${Constant.getDateTime(todoModel.create!)}",style: Theme.of(context).textTheme.bodyText1,),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
