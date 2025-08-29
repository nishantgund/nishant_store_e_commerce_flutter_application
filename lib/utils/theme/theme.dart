import 'package:flutter/material.dart';
import 'package:nishant_store/utils/theme/custom_theme/appbar_theme.dart';
import 'package:nishant_store/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:nishant_store/utils/theme/custom_theme/checkbox_theme.dart';
import 'package:nishant_store/utils/theme/custom_theme/chip_theme.dart';
import 'package:nishant_store/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:nishant_store/utils/theme/custom_theme/outline_button_theme.dart';
import 'package:nishant_store/utils/theme/custom_theme/text_filed_theme.dart';

import 'custom_theme/text_theme.dart';

class TAppTheme{
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme : TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFiledTheme.lightInputDecorationTheme
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFiledTheme.darkInputDecorationTheme,
  );

}