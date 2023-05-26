import 'package:cuoiky/ui/achievements/achievements.dart';
import 'package:cuoiky/ui/play/play.dart';
import 'package:cuoiky/ui/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: play(),
        routes: {
          '/achievements': (context) => achievements(),
        },
      ),
    );
  }
}
