import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';


class TRatingProgressIndicator extends StatelessWidget {
  const TRatingProgressIndicator({
    super.key, required this.text, required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1,child: Text(text, style: Theme.of(context).textTheme.bodyMedium,)),
        Expanded(
            flex: 11,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8 ,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: Colors.grey,
                  borderRadius: BorderRadius.circular(7),
                  valueColor: AlwaysStoppedAnimation(ColorsData.blue),
                ),
              ),
            )
        )
      ],
    );
  }
}