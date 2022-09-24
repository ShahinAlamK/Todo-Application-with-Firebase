import 'package:flutter/material.dart';



enum SlideDirection{fromTop,fromBottom,fromRight,fromLeft}
class ListAnimation extends StatefulWidget {
  final Widget child;
  final int position;
  final int item;
  final AnimationController animationController;
  final SlideDirection slideDirection;
  const ListAnimation({Key? key, required this.child, required this.position, required this.item, required this.animationController, required this.slideDirection}) : super(key: key);

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation> {
  @override
  Widget build(BuildContext context) {
    var xTranslate=0.0, yTranslate=0.0;
    var animation=Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve:Interval((1/widget.item)*widget.position,1.0,curve:Curves.fastOutSlowIn)
    ));
    widget.animationController.forward();

    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (_,child){
          if(widget.slideDirection==SlideDirection.fromTop){
            yTranslate=-50*(1.0-animation.value);
          }
          else if(widget.slideDirection==SlideDirection.fromBottom){
            yTranslate=-50*(1.0-animation.value);
          }
          return FadeTransition(
            opacity:animation,
            child: Transform(
                transform:Matrix4.translationValues(xTranslate,yTranslate,0.0),
                child: widget.child),);
        }
    );
  }
}

