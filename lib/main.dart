import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/gender_model.dart';
import 'models/age_model.dart';
import 'models/university_model.dart';
import 'models/weather_model.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GenderModel()),
        ChangeNotifierProvider(create: (_) => AgeModel()),
        ChangeNotifierProvider(create: (_) => UniversityModel()),
        ChangeNotifierProvider(create: (_) => WeatherModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-functional App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
