import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme{
  static ThemeData lightTheme (BuildContext context){
    return ThemeData(
      primarySwatch: Colors.amber,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.white,
      canvasColor: creamColor,
      buttonColor: amberDarkColor,
      accentColor: darkBluishColor,
      primaryColor: Vx.amber400,
      appBarTheme: AppBarTheme(
        color: Colors.amberAccent,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: Theme.of(context).textTheme,
      )
    );
  }

  static ThemeData darkTheme (BuildContext context){
    return ThemeData(
      brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.black,
        canvasColor: darkColor,
        buttonColor: amberCreamColor,
        accentColor: Colors.white,
        primaryColor: Vx.gray800,
        appBarTheme: AppBarTheme(
          color: Colors.amberAccent,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: Theme.of(context).textTheme.copyWith(headline6: context.textTheme.headline6!.copyWith(color: Colors.white)),
        )
    );
  }

  //Colors
  static Color creamColor = Color(0xfff5f5f5);
  static Color darkColor = Vx.gray900;
  static Color lightBluishColor = Vx.purple400;
  static Color darkBluishColor = Color(0xff403b58);
  static Color amberCreamColor = Vx.amber300;
  static Color amberDarkColor = Vx.amber700;

}