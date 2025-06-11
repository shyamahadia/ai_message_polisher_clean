import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(AIMessagePolisherApp());
}

class AIMessagePolisherApp extends StatelessWidget {
  const AIMessagePolisherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Message Polisher',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomeScreen(),
    );
  }
}
