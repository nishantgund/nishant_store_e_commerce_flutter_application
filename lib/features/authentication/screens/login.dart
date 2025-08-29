import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/authentication/controllers/login/login_controller.dart';
import 'package:nishant_store/features/authentication/screens/foreget_password.dart';
import 'package:nishant_store/features/authentication/screens/singup.dart';
import 'package:nishant_store/navigation_menu.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import 'package:nishant_store/utils/validators/t_validator.dart';

import '../../../utils/constants/GetImage.dart';
import 'TSocialMediaButton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
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
              TLoginHeader(),

              TLoginForm(),

              TFromDivider(),

              SizedBox(height: 16),

              TSocialMediaButton()
            ],
          ),
        )
      ),
    );
  }
}

class TFromDivider extends StatelessWidget {
  const TFromDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: Colors.grey, thickness: 0.5, indent: 60, endIndent: 5,)),
        Text('or sign in with',style: Theme.of(context).textTheme.labelMedium),
        Flexible(child: Divider(color: Colors.grey, thickness: 0.5, indent: 5, endIndent: 60,)),
      ],
    );
  }
}

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            children: [
              // email
              TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: 'E-Mail'),
              ),
              SizedBox(height: 16),

              // Password
              Obx(
                    () => TextFormField(
                  obscureText: controller.hidePassword.value,
                  controller: controller.password,
                  validator: (value) => TValidator.validateEmptyTextField('Password',value),
                  decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon:Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)
                      )
                  ),
                ),
              ),
              SizedBox(height: 8),

              // Remember me
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => Checkbox(value: controller.rememberMe.value ,
                          onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value )
                      ),
                      Text('Remember me')
                    ],
                  ),
                  TextButton(onPressed: () => Get.to(() => TForgetPasswordScreen()) , child: Text('Forget Password'))
                ],
              ),
              SizedBox(height: 16,), // space between sections

              // Button 'Sign In'
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn() , child: Text('Sign In'))),
              SizedBox(height: 16,),  // space between item

              // Button 'Create Account'
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(() => SingupScreen()) , child: Text('Create Account')),),
            ],
          ),
        )
    );
  }
}

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 150,
          width: 152,
          child: GetLogo(),
        ),
        // Image(
        //   height: 150,
        //   image: AssetImage(dark ? TImages.darkAppLogo : TImages.lightAppLogo),
        // ),
        SizedBox(height: 16),
        Text('Welcome back,', style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 8.0,),
        Text('Discover Limitless Choices and Unmatched Convenience.', style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}

