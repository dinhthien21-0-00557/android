import 'package:flutter/material.dart';

class lose extends StatefulWidget {
  const lose({super.key});

  @override
  State<lose> createState() => _loseState();
}

class _loseState extends State<lose> {
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
            image: AssetImage('assets/imges/losw.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
