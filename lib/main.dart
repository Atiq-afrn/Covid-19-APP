import 'package:covid_19/Views/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Covidapp());
}

class Covidapp extends StatefulWidget {
  const Covidapp({super.key});

  @override
  State<Covidapp> createState() => _CovidappState();
}

class _CovidappState extends State<Covidapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark
          // primarySwatch: Colors.blue,
          ),
      home: SplashScreen(),
    );
  }
}
