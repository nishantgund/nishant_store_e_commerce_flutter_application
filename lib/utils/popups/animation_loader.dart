import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TAnimationLoader extends StatelessWidget {
  const TAnimationLoader({
    super.key,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
    required this.text,
    required this.animation,
    this.padding = const EdgeInsets.all(0)
  });

  final String text, animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: padding,),
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8),
          SizedBox(height: 16,),
          Text(text, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
          SizedBox(height: 16,),
          showAction ?
              SizedBox(
                width: 250,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: onActionPressed,
                    child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
                    )
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }
}
