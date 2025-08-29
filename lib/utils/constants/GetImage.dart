import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/helper_functions.dart';
import 'image_strings.dart';

class GetLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var dark = THelperFunction.isDarkMode(context);
    return CircleAvatar(
        backgroundImage: AssetImage(dark ? TImages.darkAppLogo : TImages.lightAppLogo)
    );
  }
}