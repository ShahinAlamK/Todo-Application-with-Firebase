import 'package:flutter/material.dart';


class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, required this.massage}) : super(key: key);
  final String massage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(massage,style: Theme.of(context).textTheme.headline6,),
          ],
        ),
      ),
    );
  }
}
