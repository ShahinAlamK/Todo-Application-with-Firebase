import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo_model.dart';
import '../utilities/themes.dart';
import '../widgets/senckbar_widget.dart';
import 'auth_provider.dart';

class CreateTodoProvider extends ChangeNotifier{

  bool isLoading=false;

  GlobalKey<FormState> key=GlobalKey<FormState>();
  final TextEditingController titleController=TextEditingController();
  final TextEditingController descriptionController=TextEditingController();
  int selectDate=DateTime.now().millisecondsSinceEpoch;
  String startTime='08:00 pm';
  String endTime=DateFormat("hh:mm a").format(DateTime.now()).toString();


  //Todo form Validation
  Future<void>todoFormValidation(BuildContext context)async{
    if(key.currentState!.validate()){
      if(titleController.text.isEmpty || descriptionController.text.isEmpty){
        messageSnack(context,Colors.redAccent,"Invalid Form");
      }else{
        TodoModel todoModel=TodoModel(
            title:titleController.text,
            description: descriptionController.text,
            dateTime: selectDate,
            end:endTime,
            start: startTime,
            isComplete:false ,
            create: DateTime.now().millisecondsSinceEpoch
        );
        isLoading=true;

        createTask(
            uid:FirebaseAuth.instance.currentUser!.uid,
            context: context, todoModel:todoModel
        ).whenComplete((){
          isLoading=false;
          notifyListeners();
        });
        notifyListeners();
      }
    }
  }


  //user's new todo create method
  Future createTask({required BuildContext context, required uid,required TodoModel todoModel})async{
    try{
      await taskCollection.doc(uid).collection("task").doc().set({
        "title":todoModel.title,
        "description":todoModel.description,
        "isComplete":todoModel.isComplete,
        "start":todoModel.start,
        "end":todoModel.end,
        "date":todoModel.dateTime,
        "create":todoModel.create
      }).whenComplete(() =>  messageSnack(context,Colors.green,"Added new todo"));
    }on FirebaseException catch(e){
      messageSnack(context,kButtonColor,e.message!);
    }
  }


}