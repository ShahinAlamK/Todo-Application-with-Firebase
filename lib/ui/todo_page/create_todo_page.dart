import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/providers/create_todo_provider.dart';
import 'package:todo_application/utilities/constant.dart';
import 'package:todo_application/utilities/size_config.dart';
import 'package:todo_application/widgets/loading_widget.dart';
import '../../widgets/button_widget.dart';


class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({Key? key}) : super(key: key);

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {


  @override
  Widget build(BuildContext context) {

    final theme=Theme.of(context);
    final provider=Provider.of<CreateTodoProvider>(context);

    return OverLoading(
      isLoading: provider.isLoading,
      child: Scaffold(

        appBar: AppBar(
          title: Text('Create an new Todo',
            style:Theme.of(context).textTheme.headline6!.copyWith(
              fontSize:sizeConfig.screenSizeHorizontal!*5
          ),),
        ),

        body: Padding(
          padding:EdgeInsets.symmetric(horizontal: Constant.defaultPadding),
          child: SingleChildScrollView(
            physics:const BouncingScrollPhysics(),

            child: Form(
              key: provider.key,

              child: Column(
                children:[const SizedBox(height: 20,),

                  FormWidget(label: "Title",hint:"Title",controller:provider.titleController),
                  const SizedBox(height:30),

                  FormWidget(label: "Description",hint:"Description",controller:provider.descriptionController,widget: null,maxLength:3),
                  const SizedBox(height:30),

                  FormWidget(
                    label: "Date Time",
                    hint:Constant.getDateTime(
                        provider.selectDate),

                    widget:IconButton(
                        onPressed:(){_datePicker();},
                        icon:const Icon(Icons.date_range)),),

                  const SizedBox(height:30),

                  Row(
                    children: [

                      Expanded(child: FormWidget(
                        label: "Start date",
                        hint:provider.startTime,
                        widget: IconButton(
                            onPressed:(){getTimePicker(isStartDate: true);},
                            icon:const Icon(Icons.access_time_outlined)),
                      )),

                      const SizedBox(width:15),

                      Expanded(child: FormWidget(
                        label: "End date",
                        hint:provider.endTime,
                        widget:IconButton(
                            onPressed:(){getTimePicker(isStartDate: false);},
                          icon:const Icon(Icons.access_time_outlined)),)),
                    ],
                  ),

                  const SizedBox(height:30),

                 ButtonWidget(
                   onTap:(){
                     provider.todoFormValidation(context);
                   },
                   label: Text("Create Todo",style:Theme.of(context).textTheme.bodyText1!.copyWith(
                       fontSize:sizeConfig.screenSizeHorizontal!*5
                   ),),
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

  Future<void> _datePicker()async{
    DateTime?pickDate=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
    );
    if(pickDate!=null){
      setState(() {
        Provider.of<CreateTodoProvider>(context,listen: false).selectDate=pickDate.millisecondsSinceEpoch;
      });
    }
  }

  Future<void>getTimePicker({required bool isStartDate})async{
    var pickTime=await _showTimePicker();
    TimeOfDay formate=pickTime;

    if(pickTime==null){

    } if(isStartDate==true){
      setState(()=>Provider.of<CreateTodoProvider>(context).startTime=formate.format(context).toString());
    } if(isStartDate==false){
      setState(()=>Provider.of<CreateTodoProvider>(context).endTime=formate.format(context).toString());
    }
  }

 Future _showTimePicker()async{
    return showTimePicker(
        context: context,
        initialTime:TimeOfDay(
            hour:int.parse(Provider.of<CreateTodoProvider>(context,listen: false).startTime.split(":")[0]),
            minute:int.parse(Provider.of<CreateTodoProvider>(context,listen: false).startTime.split(":")[1].split(" ")[0]),
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
