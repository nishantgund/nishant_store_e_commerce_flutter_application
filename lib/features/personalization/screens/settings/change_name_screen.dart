import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/personalization/controllers/update_name_controller.dart';
import 'package:nishant_store/utils/validators/t_validator.dart';

class TChangeNameScreen extends StatelessWidget {
  const TChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TUpdateNameController());
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headline
            Text(
              'Use real name for easy verification. This name will appear in several page',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 32,),

            // Text Field and button
            Form(
              key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) => TValidator.validateEmptyText('First Name', value),
                      expands: false,
                      decoration: InputDecoration(labelText: 'First Name', prefixIcon: Icon(Iconsax.user)),
                    ),
                    SizedBox(height: 16,),

                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) => TValidator.validateEmptyText('Last Name', value),
                      expands: false,
                      decoration: InputDecoration(labelText: 'Last Name', prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                )
            ),
            SizedBox(height: 32,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.updateUserName(), child: Text('Save')),

            )
          ],
        ),
      ),
    );
  }
}
