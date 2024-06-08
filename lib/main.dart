import 'package:flutter/material.dart';
import 'package:wether_assessment_adliardhiussalam_02/wether_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home:const WeatherPage(),
     theme: ThemeData(
      primaryColor: Colors.white,
     ),
    );
  }
}

