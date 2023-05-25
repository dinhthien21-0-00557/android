import 'package:flutter/material.dart';

class win extends StatefulWidget {
  const win({super.key});

  @override
  State<win> createState() => _winState();
}

class _winState extends State<win> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imges/win2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
