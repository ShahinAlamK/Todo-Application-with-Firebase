import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, required this.massage}) : super(key: key);
  final String massage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          SvgPicture.asset("assets/undraw_personal_file.svg",height: 130,),
          Text(massage,style: Theme.of(context).textTheme.headline6,),
        ],
      ),
    );
  }
}
