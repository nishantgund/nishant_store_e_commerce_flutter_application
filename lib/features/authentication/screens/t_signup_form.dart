import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:nishant_store/utils/validators/t_validator.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'TSocialMediaButton.dart';
import 'login.dart';

class TSingUpForm extends StatelessWidget {
  const TSingUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    bool dark = THelperFunction.isDarkMode(context);
    return Form(
      key: controller.signupFromKey,
        child: Column(
          children: [
            // First & Last name
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) => TValidator.validateEmptyTextField('first name', value),
                    decoration: InputDecoration(labelText: 'First Name', prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
                SizedBox(width: 16.0,),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) => TValidator.validateEmptyTextField('last name', value),
                    decoration: InputDecoration(labelText: 'Last Name', prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),

            //username
            TextFormField(
              controller: controller.username,
              validator: (value) => TValidator.validateEmptyTextField('username', value),
              decoration: InputDecoration(labelText: 'Username', prefixIcon: Icon(Iconsax.user_edit)),
            ),
            SizedBox(height: 16),

            //Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Iconsax.direct)),
            ),
            SizedBox(height: 16),

            //Phone Number
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: controller.phoneNumber,
              validator: (value) => TValidator.validatePhoneNumber(value),
              decoration: InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Iconsax.call)),
            ),
            SizedBox(height: 16),

            // Password
            Obx(
            () => TextFormField(
                obscureText: controller.hidePassword.value,
                controller: controller.password,
                validator: (value) => TValidator.validatePassword(value),
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
            SizedBox(height: 16),

            // Tersm & Condition CheckBox
            Row(
              children: [
                SizedBox(
                    width: 24,
                    height: 24,
                    child: Obx(
                            () => Checkbox(
                                value: controller.privacyPolice.value,
                                onChanged: (value) => controller.privacyPolice.value = !controller.privacyPolice.value)
                    )
                ),
                SizedBox(width: 8,),

                Text.rich(
                    TextSpan(
                        children:[
                          TextSpan(text: 'I Agree to ', style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: 'Privacy Policy', style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark ? Colors.white : Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: dark ? Colors.white : Colors.blue
                          )),
                          TextSpan(text: ' and ', style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: 'Terms of Use', style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark ? Colors.white : Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: dark ? Colors.white : Colors.blue
                          ))
                        ]
                    )
                )
              ],
            ),
            SizedBox(height: 32),

            // Create Account Button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.signup() , child: Text('Create Account')),),
            SizedBox(height: 32),

            TFromDivider(),
            SizedBox(height: 16),

            TSocialMediaButton(),

          ],
        )
    );
  }
}