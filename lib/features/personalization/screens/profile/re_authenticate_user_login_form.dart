import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/personalization/controllers/user_controller.dart';
import 'package:nishant_store/utils/validators/t_validator.dart';

class ReAuthUserLoginForm extends StatelessWidget {
  const ReAuthUserLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: (value) => TValidator.validateEmail(value),
                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: 'Email'),
                  ),
                  SizedBox(height: 16,),

                  // Password
                  Obx(
                    () => TextFormField(
                      obscureText: controller.hidePassword.value,
                      controller: controller.verifyPassword,
                      validator: (value) => TValidator.validatePassword(value),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                              icon: Icon(Iconsax.eye_slash)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 32,),

                  // Verify Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: controller.reAuthenticateUserAndPassword, child: Text('Verify'))
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
