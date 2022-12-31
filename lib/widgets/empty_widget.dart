import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_application/utilities/size_config.dart';


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
          SvgPicture.asset("assets/undraw_personal_file.svg",height:sizeConfig.screenSizeVertical!*25),
          SizedBox(height: sizeConfig.screenSizeVertical!*3,),

          Text(massage,style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontSize:sizeConfig.screenSizeHorizontal!*4
          ),),
        ],
      ),
    );
  }
}
