import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/personalization/controllers/user_controller.dart';
import '../../../../common/widgets/shimmer.dart';
import '../../../shop/screens/store/t_circular_image.dart';


class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
        leading: Obx((){
          final networkImage = controller.user.value.profilrPicture;
          final image = networkImage.isNotEmpty ? networkImage : 'assets/images/User/user.png';
          return controller.imageUploading.value
              ? TShimmerEffects(width: 60, height: 60,radius: 60,)
              : TCircularImage(image: image,width: 60, height: 60, isNetworkImage: networkImage.isNotEmpty);
        }
        ),
        //Obx(() => TCircularImage(image: controller.user.value.profilrPicture, width: 50, height: 50, padding: 0,)),
        title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),),
        subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),overflow: TextOverflow.ellipsis,maxLines: 1,),
        trailing: IconButton(onPressed: onPressed, icon: Icon(Iconsax.edit,color: Colors.white,),
      ),
    );
  }
}