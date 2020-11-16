import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
/*  primarySwatch: MaterialColor(
    0xFFF5E0C3,
    <int, Color>{
      50: Color(0x1a5D4524),
      100: Color(0xa15D4524),
      200: Color(0xaa5D4524),
      300: Color(0xaf5D4524),
      400: Color(0x1a483112),
      500: Color(0xa1483112),
      600: Color(0xaa483112),
      700: Color(0xff483112),
      800: Color(0xaf2F1E06),
      900: Color(0xff2F1E06)
    },
  ),*/
  primaryColor: Colors.black,
  primaryColorBrightness: Brightness.dark,
  // primaryColorLight: Colors.orange,
  // primaryColorDark: Colors.orange,
  //canvasColor: Color(0xffE09E45),
  accentColor: Colors.white,
  accentColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  //bottomAppBarColor: Color(0xff6D42CE),
  //cardColor: Color(0xaa311F06),
  //dividerColor: Color(0x1f6D42CE),
  // focusColor: Colors.yellow,
  //hoverColor: Colors.yellow,
  highlightColor: Colors.green[300],
  //splashColor: Color(0xff457BE0),
//  splashFactory: # override create method from  InteractiveInkFeatureFactory
  // selectedRowColor: Colors.grey,
  //unselectedWidgetColor: Colors.yellow,
  disabledColor: Colors.grey[800], //
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    highlightColor: Colors.pink,

    height: 60,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
//button themes
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
//toggle button theme
      ),
  //buttonColor: Color(0xff483112),
  //secondaryHeaderColor: Colors.grey,
  //textSelectionColor: Color(0x1a483112),
  cursorColor: Colors.green,
  //textSelectionHandleColor: Color(0xff483112),
  //backgroundColor: Color(0xff457BE0),
  //dialogBackgroundColor: Colors.white,
  // indicatorColor: Colors.yellow,
  //hintColor: Colors.grey,
  errorColor: Colors.red,

  //toggleableActiveColor: Color(0xff6D42CE),
  textTheme: GoogleFonts.sourceCodeProTextTheme(ThemeData.dark().textTheme),

  primaryTextTheme: TextTheme(
//text theme that contrast with primary color
      ),
  accentTextTheme: TextTheme(
//text theme that contrast with accent Color
      ),
  inputDecorationTheme: InputDecorationTheme(

// default values for InputDecorator, TextField, and TextFormField
      ),
  iconTheme: IconThemeData(

//icon themes that contrast with card and canvas
      ),
  primaryIconTheme: IconThemeData(

//icon themes that contrast primary color
      ),
  accentIconTheme: IconThemeData(

//icon themes that contrast accent color
      ),
);
