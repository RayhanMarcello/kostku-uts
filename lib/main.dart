import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/kost_provider.dart';
import 'screen/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => KostProvider()..loadKost(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kostku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5FBF9),
      ),
      home: const MainScreen(),
    );
  }
}
