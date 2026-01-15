import 'package:flutter/material.dart';
import 'package:helios/widgets/AppBackground.dart';

import 'screens/onboardingi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppBackground(child: Onboardingi()),
    );
  }
}
