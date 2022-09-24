import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.onTap, this.label, this.color, this.radius=0.0}) : super(key: key);

  final VoidCallback onTap;
  final Widget? label;
  final Color?color;
  final double?radius;

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ClipRRect(
     borderRadius: BorderRadius.circular(radius!),
      child: Material(
        color:color!=null?color!:Colors.blue,
        child: InkWell(
          onTap:()=>onTap(),
          child: SizedBox(
            height: 45,
            width:size.width,
            child: Center(child:label!=null?label!:Text("Button"),),
          ),
        ),
      ),
    );
  }
}
