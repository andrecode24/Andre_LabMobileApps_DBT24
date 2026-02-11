import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/contacts_screen.dart';

void main() {
  // Set system UI overlay style for dark theme
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF121212),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
        primaryColor: Color(0xFF1DB954),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF1DB954),
          secondary: Color(0xFF1ED760),
          surface: Color(0xFF282828),
          background: Color(0xFF121212),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const ContactsScreen(),
    );
  }
}