import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/utils/constants/enum.dart';

class TBrandTitleWithVerificationIcon extends StatelessWidget {
  const TBrandTitleWithVerificationIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = Colors.blue,
    this.textAlign = TextAlign.start,
    this.brandTextSizes = TextSizes.small,
    this.isBold = false,

  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 60,
              child: Text(
                      title,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: textColor,fontWeight: isBold ? FontWeight.bold : null),
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                      textAlign: textAlign,
                ),
            ),
            SizedBox(width: 4,),
            Icon(Iconsax.verify5, color: iconColor, size: 12,)
          ],
    );
  }
}
