import 'package:flutter/material.dart';
import 'package:literahub/core/theme/app_theme.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';
import 'light_colors.dart';

class Themes {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.white,
      canvasColor: Colors.white,
      unselectedWidgetColor: Colors.black38,
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle:
            AppTextTheme.labelMedium.copyWith(color: LightColors.primaryColor),
      ),
      datePickerTheme: DatePickerThemeData(
        //cancelButtonStyle: ButtonStyle(backgroundColor: MaterialStateProperty.all(LightColors.kRed),textStyle: MaterialStateProperty.all(TextStyle(color: Colors.black)) ),
        //confirmButtonStyle: ButtonStyle(backgroundColor: MaterialStateProperty.all(kPrimaryLightColor),textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)) ),
        //dayBackgroundColor: MaterialStateProperty.all(Colors.white),
        dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return kPrimaryLightColor
                .withOpacity(0.4); // Your desired selected day color
          }
          return Colors.white; // Default unselected day color
        }),
        headerBackgroundColor: kPrimaryLightColor,
        headerForegroundColor: Colors.white,
        headerHeadlineStyle: LightColors.textHeaderStyleWhite,
        headerHelpStyle: LightColors.textHeaderStyleWhite,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      cardColor: Color.lerp(Colors.white, Colors.white, 1),
      cardTheme: CardTheme(
        color: Colors.white,
        shadowColor: LightColors.kLightGray1,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),

      /// TYPOGRAPHY
      textTheme: AppTextTheme.textTheme,
      iconTheme: IconThemeData(
        color: LightColors.primaryColor,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor:
            MaterialStateColor.resolveWith((states) => kPrimaryLightColor),
        overlayColor: MaterialStateProperty.all(Colors.white70),
        side: BorderSide(color: kPrimaryLightColor),
      ),
      radioTheme: RadioThemeData(
        fillColor:
            MaterialStateColor.resolveWith((states) => kPrimaryLightColor),
        overlayColor: MaterialStateProperty.all(LightColors.kLightGray1),
      ),

      /// COMPONENT THEMES
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: kPrimaryLightColor,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: kPrimaryLightColor,
          textStyle:
              AppTextTheme.labelMedium.copyWith(color: lightColors.error),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: BorderSide(color: lightColors.onSurface),
          foregroundColor: lightColors.onSurface,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: lightColors.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightColors.surface,
        errorStyle: AppTextTheme.bodySmall.copyWith(color: lightColors.error),
        helperStyle: AppTextTheme.bodySmall
            .copyWith(color: lightColors.onSurfaceVariant),
        hintStyle: AppTextTheme.bodyMedium
            .copyWith(color: lightColors.onSurfaceVariant),
        focusedErrorBorder: lightColors.error.getOutlineBorder,
        errorBorder: lightColors.error.getOutlineBorder,
        focusedBorder: Colors.transparent.getOutlineBorder,
        iconColor: lightColors.onSurfaceVariant,
        enabledBorder: Colors.transparent.getOutlineBorder,
        disabledBorder: Colors.transparent.getOutlineBorder,
        errorMaxLines: 3,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: lightColors.primary,
        unselectedLabelColor: lightColors.onSurfaceVariant,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: lightColors.primary,
              width: 2,
            ),
          ),
        ),
      ),

      ///Extensions
      extensions: <ThemeExtension>[
        lightColors,
      ],
      colorScheme: ColorScheme(
        brightness: lightColors.brightness,
        primary: Colors.white,
        onPrimary: kPrimaryLightColor,
        secondary: kPrimaryLightColor,
        onSecondary: lightColors.onSecondary,
        error: lightColors.error,
        onError: lightColors.onError,
        background: Colors.white,
        onBackground: Colors.white,
        surface: Colors.white,
        onSurface: Colors.white,
        surfaceVariant: lightColors.surfaceVariant,
        onSurfaceVariant: lightColors.onSurfaceVariant,
      ).copyWith(background: Colors.white).copyWith(background: Colors.white),
    );
  }

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    // scaffoldBackgroundColor: ColorConstants.gray900,
    appBarTheme: const AppBarTheme(
      // backgroundColor: ColorConstants.gray900,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        hintStyle: const TextStyle(
          fontSize: 14,
        )),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.white),
    textTheme: TextTheme(
        displayLarge: TextStyle(
            letterSpacing: -1.5,
            fontSize: 48,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            letterSpacing: -1.0,
            fontSize: 40,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            letterSpacing: -1.0,
            fontSize: 32,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 28,
            fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 24,
            fontWeight: FontWeight.w500),
        titleLarge: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        titleMedium: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        titleSmall: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        labelLarge: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
        bodySmall: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        labelSmall: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 10,
            fontWeight: FontWeight.w400)),
  );
}

AppColors get lightColors => const AppColors(
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Color(0xFF002231),
      secondary: Color(0xFF8859FF),
      onSecondary: Color(0XFFFFFFFF),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF002E42),
      surface: Color(0xFFF2F5F6),
      onSurface: Color(0xFF002E42),
      surfaceVariant: Color(0xFFF2F5F6),
      onSurfaceVariant: Color(0xFF667C86),
      success: Color(0xFF27BA62),
      onSuccess: Color(0xFFFFFFFF),
      error: Color(0xFFDB1A3A),
      onError: Color(0xFFFFFFFF),

      /// Custom colors
      tileBackgroundColor: Color(0xFFF2F5F6),
      defaultText: Color(0XFF002E42),
      lightText: Color(0XFF667C86),
      defaultIcon: Color(0XFFBFCBD0),
      disabledIcon: Color(0XFF8097A0),
      disabledSurface: Color(0XFFD2DBDE),
      onDisabledSurface: Color(0XFFA0B1B8),
      linearGradient: LinearGradient(
        colors: [
          Color(0xFFC55F84),
          Color(0xFFC55F84),
          Color(0xFFC55F84),
        ],
      ),
    );
