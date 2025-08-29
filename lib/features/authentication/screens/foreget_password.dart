import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:nishant_store/utils/validators/t_validator.dart';

class TForgetPasswordScreen extends StatelessWidget {
  TForgetPasswordScreen({super.key});

  String subTitle = "Don't Worry Sometimes People can Forget too. Enter your Email and We will Send You a Password Reset Link";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forget Password', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              SizedBox(height: 16,),

              Text('$subTitle', style: Theme.of(context).textTheme.labelMedium,),
              SizedBox(height: 64,),

              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  validator: (value) => TValidator.validateEmail(value),
                  decoration: InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: 'E-Mail'),
                ),
              ),
              SizedBox(height: 32),
              
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.sendPasswordResetMail(), child: Text('Submit')),)
            ],
          ),
        ),
    );
  }
}
