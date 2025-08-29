import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';


class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.textColor,
    this.showActionBar = true,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed,
    this.buttonColor = ColorsData.blue,
  });

  final Color? textColor;
  final bool showActionBar;
  final String title, buttonTitle;
  final void Function()? onPressed;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),maxLines: 1, overflow: TextOverflow.ellipsis,),
        if(showActionBar) TextButton(onPressed: onPressed, child: Text(buttonTitle, style: TextStyle(color: buttonColor),))
      ],
    );
  }
}