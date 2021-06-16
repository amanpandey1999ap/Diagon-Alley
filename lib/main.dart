import 'package:diagon_alley/screens/home_page.dart';
import 'package:diagon_alley/screens/login_page.dart';
import 'package:diagon_alley/utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
      debugShowCheckedModeBanner: true,
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: GoogleFonts.lato().fontFamily),
      darkTheme: ThemeData(brightness: Brightness.dark),

      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
      },
    );
  }
}
