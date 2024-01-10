import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:bingevibes/Pages/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Binge Vibes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:const ColorScheme.light()
      ),
      home: const Welcomepage(),
      );
  }
}
