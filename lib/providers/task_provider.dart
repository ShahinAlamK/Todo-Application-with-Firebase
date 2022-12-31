import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/providers/auth_provider.dart';
import 'package:todo_application/utilities/themes.dart';
import 'package:todo_application/widgets/senckbar_widget.dart';


class TaskProvider extends ChangeNotifier{

  // Start Todos Getting
  List<TodoModel> get taskList=>_taskModel;
  List<TodoModel> _taskModel=[];

  bool get isLoading=>_isLoading;
  bool _isLoading=true;

  String get error=>_error!;
  String?_error;

  setLoading(bool loading){
    _isLoading=loading;
    notifyListeners();
  }

  setData(List<TodoModel> taskModel)async{
    _taskModel=taskModel;
    setLoading(false);
    notifyListeners();
  }


  //All todo fetching method
  //unique user for results
  fetchTask({required uid})async{
    List<TodoModel>temp=[];
    try {
      await taskCollection.doc(uid).collection("task").orderBy("isComplete",descending: false).get().then((QuerySnapshot snapshot){
        for(var element in snapshot.docs){
         TodoModel todoModel=TodoModel(
           id: element.id,
           title: element['title'],
           description: element['description'],
           start:element['start'],
           end: element['end'],
           isComplete: element['isComplete'],
           create: element.get("create"),
         );
         temp.add(todoModel);
        }
      });
      setData(temp);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }
  //End Todos

 List<TodoModel>get completeTodo=>_taskModel.where((element) => element.isComplete==true).toList();
 List<TodoModel>get unCompleteTodo=>_taskModel.where((element) => element.isComplete==false).toList();


Future<void>deleteTask({required BuildContext context,required uid, required String id})async{
  try {
    await profileCollection.doc(uid).collection("task").doc(id).delete()
        .whenComplete(() =>  messageSnack(context,Colors.green,"Deleted todo"));
  }on FirebaseException catch(e){
    messageSnack(context,kButtonColor,e.message!);
  }
}

//Start Update
Future<void>updateComplete({required BuildContext context,required uid,required id, required bool isComplete})async{
  try {
    await profileCollection.doc(uid).collection("task").doc(id).update({
      "isComplete":isComplete,
    });
  }on FirebaseException catch(e){
    messageSnack(context,kButtonColor,e.message!);
  }
}
//End Update

}