import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/features/authentication/controllers/login/login_controller.dart';

import '../../../utils/constants/image_strings.dart';

class TSocialMediaButton extends StatelessWidget {
  const TSocialMediaButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () => controller.googleSignIn(),
              icon: Image(
                  height: 24,
                  width: 24,
                  image: AssetImage(TImages.googleLogo)
              )
          ),
        ),
        SizedBox(width: 16,),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: (){},
              icon: Image(
                  height: 24,
                  width: 24,
                  image: AssetImage(TImages.facebookLogo)
              )
          ),
        ),
      ],
    );
  }
}