import 'package:flutter/material.dart';

import '../../../../utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.onPressed,
    this.isNetworkImage = true,
  });

  final bool isNetworkImage;
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onPressed;

  // , color: THelperFunction.isDarkMode(context) ? Colors.black : Colors.white

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circule Avtar
            Container(
              height: 56,
              width: 56,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: backgroundColor ?? (THelperFunction.isDarkMode(context) ? Colors.black : Colors.white)
              ),
              child: Center(
                child: Image(image: isNetworkImage ? NetworkImage(image) : AssetImage(image)  as ImageProvider, fit: BoxFit.cover,)
              ),
            ),
            SizedBox(height: 8,),

            // Product Title
            SizedBox(
                width: 55,
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Text(title, style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor), overflow: TextOverflow.ellipsis, maxLines: 1,),
            ))
          ],
        ),
      ),
    );
  }
}