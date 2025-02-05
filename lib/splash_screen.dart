import 'package:flutter/material.dart';
import 'package:the_cat_api_duvan/config/theme/app_theme.dart';
import 'package:the_cat_api_duvan/modules/home/screens/home.dart';

class SplashScreenWithDelay extends StatefulWidget {
  const SplashScreenWithDelay({super.key});

  @override
  SplashScreenWithDelayState createState() => SplashScreenWithDelayState();
}

class SplashScreenWithDelayState extends State<SplashScreenWithDelay> {
  bool _isVisible = true; // Controla la visibilidad para la animación

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          // change the visibility to false after 2 seconds
          _isVisible = false;
        });
      }
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0, // Cambia la opacidad
          duration: const Duration(seconds: 1), // Duración de la animación
          child: Image.asset(
            'assets/images/logo.png',
            width: 200,
          ),
        ),
      ),
      backgroundColor: primaryColor,
    );
  }
}
