import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/data/repositories/authentication/authentication_repository.dart';
import 'package:nishant_store/features/authentication/controllers/signup/email_verification_controller.dart';
import 'package:nishant_store/utils/constants/image_strings.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

class TVerifyEmailScreen extends StatelessWidget {
  TVerifyEmailScreen({super.key, required this.email});

  final String email;

  String subTitle1 = 'Congratulation! your Account Await. Verify Your Email to Start Shopping and Experience a World of Unrivaled Deals and Personalized Offers';
  String subTitle2 = "Welcome to Your Ultimate Shopping Destination. Your Account is Created. Unleash the Joy of Seamless Online Shopping!";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailVerificationController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                // Image
                Image(image: AssetImage(TImages.deliveredEmailIllustration),width: THelperFunction.screenWidth() * 0.6,height: THelperFunction.screenHeight() * 0.3),
                SizedBox(height: 32,),

                // HeadLine And SubTitle
                Text('Verify Your Email Address', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
                SizedBox(height: 16,),

                Text( email, style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
                SizedBox(height: 16,),

                Text('$subTitle1', style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
                SizedBox(height: 32,),

                // Continue Button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.checkEmailVerificationStatus(),
                      child: Text('Continue'),
                    )
                ),
                SizedBox(height: 16,),
                SizedBox(width: double.infinity, child: TextButton(onPressed: () => controller.sendEmailVerification() , child: Text('Resend Email')),)
              ],
            ),
          )
        ),
      ),
    );
  }
}
