import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cryptostats/constants/Themes.dart';
import 'package:cryptostats/models/LocalStorage.dart';
import 'package:cryptostats/pages/Login.dart';
import 'package:cryptostats/providers/market_provider.dart';
import 'package:cryptostats/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBBi4gLml3OwBA1NvVCtcTHswBcDPjkPUo",
      appId: "1:416711428289:android:a0121196176408eebf6c40",
      messagingSenderId: "416711428289",
      projectId: "cryptostatsapp-d7bf2",
    ),
  );
  String currentTheme = await LocalStorage.getTheme() ?? "light";
  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  const MyApp({super.key, required this.theme});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(theme),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png"),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 0, 113, 197),
      nextScreen: const LoginScreen(),
      splashIconSize: 200,
      duration: 1000,
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      animationDuration: const Duration(seconds: 3),
    );
  }
}
