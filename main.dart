




import 'package:flutter/material.dart';


import 'package:untitled/home_screen.dart';



void main() {
  runApp(MyApp());
}
class Colours{
  static const scaffoldByColor=Color(0xFF23272E);
  static const ratingColor=Color(0xFFFFC107);
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Flutflix',
theme: ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colours.scaffoldByColor,
  useMaterial3: true,
),
home: HomeScreen(),
   );
  }
}





