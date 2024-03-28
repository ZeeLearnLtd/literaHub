import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'hex.dart';

final kPrimaryLightColor = HexColor.fromHex('#1b99ed');

const kDefaultPadding = 20.0;

const kPrimaryColor = Color(0xFF366CF6);
const kSecondaryColor = Color(0xFFF5F6FC);
const kBgLightColor = Color(0xFFF2F4FC);
const kBgDarkColor = Color(0xFFEBEDFA);
const kBadgeColor = Color(0xFFEE376E);
const kGrayColor = Color(0xFF8793B2);
const kTitleTextColor = Color(0xFF30384D);
const kTextColor = Color(0xFF4D5875);

class LightColors {
  static AppColors get lightColors => const AppColors(
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
  static const Color primaryColor = Color.fromRGBO(86, 215, 188, 1);
  static const Color appbackground = Colors.white;
  static Color headerColors = Colors.white.withOpacity(0.3);

  static const Color kLightYellow = Color(0xFFFFF9EC);
  static const Color kLightYellow2 = Color(0xFFFFE4C7);
  static const Color kDarkYellow = Color(0xFFF9BE7C);
  static const Color kPalePink = Color(0xFFFED4D6);

  static const Color kRed = Color(0xFFE46472);
  static const Color kLavender = Color(0xFFD5E4FE);
  static const Color kBlue = Color(0xFF6488E4);
  static const Color kLightGreen = Color(0xFFD9E6DC);
  static const Color kGreen = Color(0xFF309397);
  static const Color kYallow = Color(0xFF309397);

  static const Color kDarkBlue = Color(0xFF0D253F);
  static const Color kLightBlue = Color(0xFFE8F5E9);
  static const Color kLightOrange = Color(0xFFFFE0B2);
  static const Color kDarkOrange = Color(0xFFFFCC80);
  static const Color kLightFULLDAY = Color(0xFFF1F8E9);
  static const Color kFULLDAY_BUTTON = Color(0xFFB2EBF2);
  static const Color kAbsent = Color(0xFFFBE9E7);
  static const Color kAbsent_BUTTON = Color(0xFFFFCDD2);
  static const Color kLightRed = Color(0xFFFFEBEE);

  static const Color kLightGray = Color(0xFFF5F5F5);
  static const Color kLightGray1 = Color(0xFFE0E0E0);
  static const Color kHeaderColor = Color.fromRGBO(234, 237, 237, 92);
  static const Color kLightGrayM = Color.fromRGBO(242, 243, 244, 95);
  static const Color kLightRedMaterial = Color.fromRGBO(250, 219, 216, 95);
  static const Color kLightGreenMaterial = Color.fromRGBO(169, 223, 191, 71);
  static const Color kLightBlueMaterial = Color.fromRGBO(52, 152, 219, 53);

  static const canvasColor = Color(0xFF2E2E48);
  static const scaffoldBackgroundColor = Color(0xFF464667);
  static const accentCanvasColor = Color(0xFF3E3E61);
  static const white = Colors.white;
  static final actionColor = Color(0xFF5F5FA7).withOpacity(0.6);
  static final divider = Divider(color: white.withOpacity(0.3), height: 1);

  static const Color TextColor = Color.fromARGB(255, 14, 44, 83);
  static const Color kBackgroundColor = Color.fromARGB(224, 224, 224, 255);

  //static const TextStyle pentemindTextStyle = TextStyle(color: TextColor,fontFamily: 'albertSans', fontSize: 16);
  static TextStyle textHeaderStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 18 : 16.0,
    color: const Color.fromARGB(255, 14, 44, 83),
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  static TextStyle textHeaderStyleWhite = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 18 : 16.0,
    color: Colors.white,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  static TextStyle menuStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 18 : 14.0,
    color: Colors.white,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle hintTextStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 18 : 16.0,
    color: const Color(0xFF4B39EF),
    fontWeight: FontWeight.normal,
    backgroundColor: LightColors.kAbsent,
    height: 1.5,
  );

  static TextStyle textHeaderStyle16 = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 18 : 16.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle textHeaderStyle13 = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 15 : 13.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle textHeaderStyle13Selected = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 15 : 13.0,
    color: Colors.white,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  static TextStyle textHeaderStyle13Unselected = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 15 : 13.0,
    color: Colors.white24,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  static TextStyle textbigStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 20 : 18.0,
    color: LightColors.TextColor,
  );
  static TextStyle textSmallStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 16 : 12.0,
    color: LightColors.kDarkBlue,
    fontWeight: FontWeight.normal,
    height: 1,
  );

  static TextStyle textSmallHightliteStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 14 : 12.0,
    color: LightColors.kLightBlueMaterial,
    fontWeight: FontWeight.normal,
    height: 1,
  );
  static TextStyle textvSmallStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 14 : 8.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.normal,
    height: 1,
  );

  static TextStyle textsubtitle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 14 : 12.0,
    color: LightColors.kLightGrayM,
    fontWeight: FontWeight.normal,
    height: 1,
  );
  static TextStyle textStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 17 : 12.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  static TextStyle textbuttonStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 20 : 18.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );
  static TextStyle subTextStyle = GoogleFonts.poppins(
    color: LightColors.TextColor,
    fontSize: kIsWeb ? 12 : 11.0,
  ) /*GoogleFonts.albertSans(
    fontSize: 10.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.w600,
    height: 1.5,
  )*/
      ;
  static TextStyle smallTextStyle = GoogleFonts.poppins(
    color: LightColors.TextColor,
    fontSize: kIsWeb ? 9 : 8.0,
  );
  static TextStyle smallTextBoldStyle = GoogleFonts.actor(
    color: LightColors.TextColor,
    fontSize: kIsWeb ? 12 : 10.0,
    fontWeight: FontWeight.normal,
  );
  static TextStyle smallTextBoldStyleWeb = GoogleFonts.roboto(
    color: LightColors.TextColor.withOpacity(0.8),
    fontSize: kIsWeb ? 14 : 12.0,
    fontWeight: FontWeight.w600,
  );
  static TextStyle absentRoundedStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 14 : 12.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static TextStyle headerBoldStyle = GoogleFonts.roboto(
    fontSize: kIsWeb ? 12 : 13.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );
  static TextStyle headerStyle = GoogleFonts.roboto(
    fontSize: kIsWeb ? 12 : 12.0,
    color: LightColors.TextColor,
    height: 1.4,
  );

  static TextStyle subtitleSelectedStyle = GoogleFonts.roboto(
    fontSize: kIsWeb ? 18 : 12.0,
    color: kPrimaryLightColor,
    fontWeight: FontWeight.w300,
    height: 1.4,
  );
  static TextStyle headerSelectedStyle = GoogleFonts.roboto(
    fontSize: kIsWeb ? 20 : 14.0,
    color: kPrimaryLightColor,
    fontWeight: FontWeight.w300,
    height: 1.5,
  );

  static TextStyle headerSelectedStyle16 = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 20 : 16.0,
    color: kPrimaryLightColor,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );
  static TextStyle headerSelectedStyle15 = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 20 : 15.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle subtitleStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 14 : 12.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle subtitleBoldStyle = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 14 : 12.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.w800,
    height: 1.5,
  );

  static TextStyle titleboldStyle = GoogleFonts.roboto(
    fontSize: kIsWeb ? 16 : 12.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subtitleStyleSelected = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 18 : 12.0,
    color: kPrimaryLightColor,
    fontWeight: FontWeight.normal,
    height: 1.2,
  );

  static TextStyle subtitleStyle12 = GoogleFonts.roboto(
    fontSize: kIsWeb ? 15 : 12.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle subtitleStyle10 = GoogleFonts.roboto(
    fontSize: kIsWeb ? 13 : 10.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle subtitleStyle10White = GoogleFonts.roboto(
    fontSize: kIsWeb ? 10 : 8.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  static TextStyle subtitleStyleHeader = GoogleFonts.roboto(
    fontSize: kIsWeb ? 13 : 10.0,
    color: Colors.black54,
  );
  static TextStyle subtitleStyle8 = GoogleFonts.roboto(
    fontSize: kIsWeb ? 11 : 10.0,
    color: LightColors.TextColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle subtitleStyle8Normal = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 11 : 10.0,
    color: LightColors.TextColor,
  );
  static TextStyle subtitleStylePrimary = GoogleFonts.albertSans(
    fontSize: kIsWeb ? 12 : 10.0,
    color: kPrimaryLightColor,
    fontWeight: FontWeight.normal,
  );

  static TextStyle hintTextStyle1 =
      TextStyle(color: Colors.black87, fontSize: 12);
  //static const TextStyle pentemindTextStyle = TextStyle(color: TextColor,fontFamily: 'albertSans', fontSize: 16);
  //static const TextStyle pentemindSubTextStyle = TextStyle(color: TextColor,fontFamily: 'albertSans', fontSize: 12);
}
