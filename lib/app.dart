import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';

class CineVerseApp extends StatelessWidget {
  const CineVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineVerse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainScreen(),
    );
  }
}
