import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/providers/task_provider.dart';
import 'package:todo_application/utilities/constant.dart';
import 'package:todo_application/widgets/loading_widget.dart';
import 'package:todo_application/widgets/senckbar_widget.dart';

import '../widgets/button_widget.dart';


class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({Key? key}) : super(key: key);

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {

  bool isLoading=false;

  final _key=GlobalKey<FormState>();
  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();
  int _selectDate=DateTime.now().millisecondsSinceEpoch;
    String _startTime='08:00 pm';
    String _endTime=DateFormat("hh:mm a").format(DateTime.now()).toString();


    storeTodo()async{
      if(_key.currentState!.validate()){
        if(_titleController.text.isEmpty || _descriptionController.text.isEmpty){
          messageSnack(context,Colors.redAccent,"Invalid Form");
        }else{
          TodoModel todoModel=TodoModel(
            title:_titleController.text,
            description: _descriptionController.text,
            dateTime: _selectDate,
            end:_endTime,
            start: _startTime,
            isComplete:false ,
          );
          setState(()=>isLoading=true);

          Provider.of<TaskProvider>(context,listen: false).createTask(
              uid:FirebaseAuth.instance.currentUser!.uid,
              context: context, todoModel:todoModel
          ).whenComplete((){
            setState(()=>isLoading=false);
          });
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return OverLoading(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create an new Todo',style: theme.textTheme.headline6,),
        ),
        body: Padding(
          padding:EdgeInsets.symmetric(horizontal: Constant.defaultPadding),
          child: SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Column(
                children:[const SizedBox(height: 20,),

                  FormWidget(label: "Title",hint:"Title",controller:_titleController),
                  const SizedBox(height:30),
                  FormWidget(label: "Description",hint:"Description",controller:_descriptionController,widget: null,maxLength:3),
                  const SizedBox(height:30),
                  FormWidget(label: "Date Time",hint:Constant.getDateTime(_selectDate),widget:IconButton(onPressed:(){
                    _datePicker();
                  }, icon:const Icon(Icons.date_range)),),

                  const SizedBox(height:30),
                  Row(
                    children: [
                      Expanded(child: FormWidget(label: "Start date",hint:_startTime,widget: IconButton(onPressed:(){
                        getTimePicker(isStartDate: true);
                      }, icon:const Icon(Icons.access_time_outlined)),)),

                      const SizedBox(width:15),

                      Expanded(child: FormWidget(label: "End date",hint:_endTime,widget:IconButton(onPressed:(){
                        getTimePicker(isStartDate: false);
                      }, icon:const Icon(Icons.access_time_outlined)),)),
                    ],
                  ),

                  const SizedBox(height:30),

                 ButtonWidget(
                   onTap:(){
                     storeTodo();
                   },
                   label: Text("Create Todo",style:theme.textTheme.bodyText1,),
                   color:theme.colorScheme.secondary,
                   radius: 7,
                 )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _datePicker()async{
    DateTime?pickDate=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
    );
    if(pickDate!=null){
      setState(() {
        _selectDate=pickDate.millisecondsSinceEpoch;
      });
    }
  }

  getTimePicker({required bool isStartDate})async{
    var pickTime=await _showTimePicker();
    TimeOfDay formate=pickTime;

    if(pickTime==null){

    } if(isStartDate==true){
      setState(()=>_startTime=formate.format(context).toString());
    } if(isStartDate==false){
      setState(()=>_endTime=formate.format(context).toString());
    }
  }

 Future _showTimePicker()async{
    return showTimePicker(
        context: context,
        initialTime:TimeOfDay(
            hour:int.parse(_startTime.split(":")[0]),
            minute:int.parse(_startTime.split(":")[1].split(" ")[0]),
        ),
    );
  }
}

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.widget,
    this.maxLength
  }) : super(key: key);

  final String?label,hint;
  final TextEditingController?controller;
  final Widget? widget;
  final int?maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label!,style: Theme.of(context).textTheme.bodyText2,),
        const SizedBox(height: 10,),

        TextFormField(
          maxLines: maxLength,
          controller: controller,
          readOnly:widget==null?false:true,
          decoration:InputDecoration(
             hintText:hint,
            filled: true,
            suffixIcon: widget!=null?widget!:null
          ),
        ),
      ],
    );
  }
}
