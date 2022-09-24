import 'package:flutter/material.dart';

class OverLoading extends StatelessWidget {
  const OverLoading({Key? key, required this.child, required this.isLoading}) : super(key: key);
  final Widget child;
  final bool isLoading;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(isLoading)...[
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.04)
              ),
              child: Container(
                  padding:const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    //   color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child:const CircularProgressIndicator())),
        ]

      ],
    );
  }
}
