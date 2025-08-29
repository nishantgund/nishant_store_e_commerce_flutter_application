import 'package:flutter/material.dart';
import 'package:nishant_store/app.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/helper_functions.dart';

class TSuccessScreen extends StatelessWidget {
  const TSuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
              top: 56.0,  //appBarHeight
              bottom: 24.0,  //defaultSpacing
              right: 24.0,
              left: 24.0,
            ),
          child: Column(
            children: [
              // Image
              Image(image: AssetImage(image),width: THelperFunction.screenWidth() * 0.6,height: THelperFunction.screenHeight() * 0.3),
              SizedBox(height: 32,),

              // HeadLine And SubTitle
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              SizedBox(height: 16,),

              Text('$subTitle', style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              SizedBox(height: 32,),

              // Continue Button
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressed, child: Text('Continue'),)),
              SizedBox(height: 16,),

            ],
          ),
        ),
      ),
    );
  }
}
