import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nishant_store/utils/constants/colors.dart';
import 'package:nishant_store/utils/theme/theme.dart';
import 'bindings/general_binding.dart';


class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBinding(),
      home: Scaffold(backgroundColor: ColorsData.blue ,body: Center(child: CircularProgressIndicator(color: Colors.white,)),)
    );
  }
}