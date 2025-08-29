import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nishant_store/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:nishant_store/utils/constants/image_strings.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.upadatePageIndicator,
            children: [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: 'Choose Your Product',
                subTitle: 'Welcome to the World of Limitless Choices - Your Perfect Product Awaits!',
              ),
              OnBoardingPage(
                  image: TImages.onBoardingImage2,
                  title: 'Select Payment Method',
                  subTitle: 'For Seamless Transaction, Choose Your Payment Path - Your Convenience, Our Priority!'
              ),
              OnBoardingPage(
                  image: TImages.onBoardingImage3,
                  title: 'Delivery at your Door Step',
                  subTitle: 'From Our DoorStep to Yours - Swift, Secure and Contactless Delivery!'
              ),
            ],
          ),
          OnBoardingSkipButton(),
          OnBoardingDotNavigation(),
          OnBoardingNextButton()
        ],
      ),
    );
  }

}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Positioned(
        bottom: THelperFunction.getBottomNavigationBarHeight(),
        right: 20,
        child: ElevatedButton(
          onPressed: (){
            OnBoardingController.instance.nextPage();
          },
          child: Icon(Iconsax.arrow_right_3,),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: dark ? Colors.blue : Colors.black,
          ),
        )
    );
  }
}

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = THelperFunction.isDarkMode(context);

    return Positioned(
      bottom: THelperFunction.getBottomNavigationBarHeight() + 25,
        left: 20,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect : ExpandingDotsEffect(activeDotColor: dark ? Colors.white : Colors.black, dotHeight: 6),
        )
    );
  }
}

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return Positioned(
        top: THelperFunction.getAppBarHeight(),
        right: 20,
        child: ElevatedButton(
            onPressed: (){
              OnBoardingController.instance.skipPage();
            },
            child: Text('Skip'),style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,foregroundColor: dark ? Colors.white : Colors.black,side: BorderSide(color: Colors.white))
        )
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 11.0, bottom: 8.0, right: 8.0, left: 8.0),
      child: Column(
        children: [
          Image(
            width: THelperFunction.screenWidth() * 0.8,
              height: THelperFunction.screenHeight() * 0.6,
              image: AssetImage(image)
          ),
          Text(title, style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
          Text(subTitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}