import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nishant_store/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:nishant_store/utils/constants/image_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'login.dart';

class TResetPasswordScreen extends StatelessWidget {
  const TResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    String subTitle = "Your Account Security is Our Priority! We've Send You the Secure Link to Safe Change Your Password and Keep Your Account Protect.";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              // Image
              Image(image: AssetImage(TImages.deliveredEmailIllustration),width: THelperFunction.screenWidth() * 0.6,height: THelperFunction.screenHeight() * 0.3),
              SizedBox(height: 32,),

              // Email
              Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
              SizedBox(height: 16,),

              // HeadLine And SubTitle
              Text('Password Reset Email Send', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              SizedBox(height: 16,),

              Text('$subTitle', style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              SizedBox(height: 32,),

              // Continue Button
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.offAll(() => LoginScreen()) , child: Text('Done'),)),
              SizedBox(height: 32,),
              
              SizedBox(width: double.infinity, child: TextButton(onPressed: () => controller.resendPasswordResetMail(email) , child: Text('Resend Email')),)
            ],
          ),
        ),
      ),
    );
  }
}
