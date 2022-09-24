import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({Key? key,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        Text("All Todo",style:theme.textTheme.headline6,),
        Text("Total todo : 30",style:theme.textTheme.bodyText2,),
      ],
    );
  }
}