import 'dart:math';
import 'package:flutter/material.dart';

Route customRoute(Widget page){
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds:400),
    reverseTransitionDuration: const Duration(milliseconds:300),
    pageBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return page;
    },
    transitionsBuilder:(BuildContext context, Animation<double> animation,Animation<double> secondaryAnimation, Widget child){
      const begin = Offset(0.7, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final Ftween = Tween(begin: 0.0, end:01.0);
      final offsetAnimation = animation.drive(tween);
      final fadeOpacity=animation.drive(Ftween);


      return FadeTransition(
        opacity:fadeOpacity,
        child: SlideTransition(
          position: offsetAnimation,
          child: child,
        ),
      );
    }
  );
}

//Animation Slide Direction
enum AnimDirection{fromTop,fromBottom,fromRight,fromLeft}

class CustomAnimatedWidget extends StatefulWidget {
  const CustomAnimatedWidget({Key? key, required this.animationController,this.child, this.wSlideDirection,}) : super(key: key);

  final AnimationController animationController;
  final Widget? child;
  final AnimDirection?wSlideDirection;

  @override
  State<CustomAnimatedWidget> createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget>{


  @override
  Widget build(BuildContext context) {

    var xTranslate=0.0, yTranslate=0.0;
    var fadeAnimation=Tween(begin: 0.0,end:01.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve:Curves.easeIn
    ));

    final animation=Tween(begin: 0,end:1.0).animate(widget.animationController);
    widget.animationController.forward();
    return AnimatedBuilder(
        animation: animation,
        builder: (_,child){

          if(widget.wSlideDirection==AnimDirection.fromTop){
            yTranslate=-30*(1.0-animation.value);
          }if(widget.wSlideDirection==AnimDirection.fromBottom){
            yTranslate=20*(1.0-animation.value);
          }if(widget.wSlideDirection==AnimDirection.fromLeft){
            xTranslate=20*(1.0-animation.value);
          }if(widget.wSlideDirection==AnimDirection.fromRight){
            xTranslate=-20*(1.0-animation.value);
          }

          return FadeTransition(
            opacity:fadeAnimation,
            child:Transform(
              transform: Matrix4.translationValues(xTranslate,yTranslate,0),
              child: widget.child,
            )
          );
    });
  }
}
