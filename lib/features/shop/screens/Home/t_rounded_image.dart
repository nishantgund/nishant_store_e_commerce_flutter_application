import 'package:flutter/material.dart';


class TRoundImage extends StatelessWidget {
  const TRoundImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = Colors.white,
    this.fit = BoxFit.fill,
    this.padding ,
    this.isNetworkImage = false,
    this.onPressed,
    this.boarderRadius = 16,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double boarderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(boarderRadius),
        ),
        child: ClipRRect(
            borderRadius: applyImageRadius ? BorderRadius.circular(boarderRadius) : BorderRadius.zero,
            child: Image(image: isNetworkImage ? NetworkImage(imageUrl) : AssetImage(imageUrl) as ImageProvider, fit: fit,)
        ),
      ),
    );
  }
}