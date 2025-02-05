import 'package:flutter/material.dart';
import 'package:the_cat_api_duvan/config/theme/app_theme.dart';
import 'package:the_cat_api_duvan/modules/home/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // this is used to close the keyboard when the user taps outside the TextField in the entire app
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        home: const HomeScreen(),
        theme: AppTheme.normalTheme,
      ),
    );
  }
}
