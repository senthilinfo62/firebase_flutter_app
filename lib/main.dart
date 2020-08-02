import 'package:firebase_flutter_app/FirebaseMessageingDemo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    HomeApp(),
  );
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseMessagingDemo(),
    );
  }
}
