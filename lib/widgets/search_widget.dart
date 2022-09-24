import 'package:flutter/material.dart';
import 'package:todo_application/utilities/constant.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Container(
      height: 45,
     // margin: EdgeInsets.symmetric(horizontal:Constant.defaultPadding,),
      padding:EdgeInsets.symmetric(horizontal:Constant.defaultPadding),
      width:double.infinity,
      decoration: BoxDecoration(
        color:Colors.blueGrey.withOpacity(.1),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search),
         const SizedBox(width: 10,),

          Expanded(child: TextFormField(
            style: theme.textTheme.bodyText1,
            decoration:const InputDecoration(
              border: InputBorder.none,
              hintText: "Search task"
            ),
          ))
        ],
      ),
    );
  }
}
