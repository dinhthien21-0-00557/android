import 'package:flutter/material.dart';

class doanScreen extends StatefulWidget {
  const doanScreen({super.key});

  @override
  State<doanScreen> createState() => _doanScreenState();
}

class _doanScreenState extends State<doanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          'Kéo Búa Bao ',
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
        actions: [
          ...List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
