import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/common/widgets/shimmer.dart';
import 'package:nishant_store/features/personalization/screens/settings/change_name_screen.dart';
import 'package:nishant_store/features/personalization/screens/settings/t_profile_menu.dart';
import 'package:nishant_store/features/shop/screens/Home/seaction_heading.dart';
import 'package:nishant_store/features/shop/screens/store/t_circular_image.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../controllers/user_controller.dart';

class TProfileCard extends StatelessWidget {
  const TProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    var dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile', style: Theme.of(context).textTheme.headlineMedium,),
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left, color: dark ? Colors.white : Colors.black,),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx((){
                      final networkImage = controller.user.value.profilrPicture;
                      final image = networkImage.isNotEmpty ? networkImage : 'assets/images/User/user.png';
                        return controller.imageUploading.value
                            ? TShimmerEffects(width: 80, height: 80,radius: 80,)
                            : TCircularImage(image: image,width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty);
                      }
                    ),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: Text('Change Profile Picture', style: TextStyle(color: ColorsData.blue),)),
                  ],
                ),
              ),

              // Details
              SizedBox(height: 8,),
              Divider(),
              SizedBox(height: 16,),

              // Profile Information
              TSectionHeading(title: 'Profile Information', showActionBar: false,),
              SizedBox(height: 16,),

              TProfileMenu(title: 'Name', value: controller.user.value.fullName,onPressed: () => Get.to(TChangeNameScreen()),),
              TProfileMenu(title: 'Username', value: controller.user.value.userame ,onPressed: (){},),

              SizedBox(height: 8,),
              Divider(),
              SizedBox(height: 16,),

              // Personal Information
              TSectionHeading(title: 'Personal Information',showActionBar: false,),
              SizedBox(height: 16,),

              TProfileMenu(title: 'User-ID', value: controller.user.value.id,onPressed: (){},icon: Iconsax.copy,),
              TProfileMenu(title: 'E-mail', value: controller.user.value.email, onPressed: (){},),
              TProfileMenu(title: 'Phone Number', value: "+91-${controller.user.value.phoneNumber}",onPressed: (){},),
              TProfileMenu(title: 'Gender', value: 'Male',onPressed: (){},),
              TProfileMenu(title: 'Date of Birth', value: '11-05-2004',onPressed: (){},),
              SizedBox(height: 16,),
              Divider(),
              SizedBox(height: 16,),

              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: Text('Close Account', style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.red))
                ),
              )

            ],
          ),
        ),
      ),
    );
      
  }
}


