import 'package:flutter/material.dart';

messageSnack(BuildContext context,Color bg,String title)async{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
              color:bg,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline),
              const SizedBox(width: 10,),
             Expanded(child:  Text(title,style: Theme.of(context).textTheme.bodyText1,),)
            ],
          ))));
}