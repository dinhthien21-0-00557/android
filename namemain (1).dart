import 'package:flutter/material.dart';

class drawer2 extends StatefulWidget {
  const drawer2({super.key});

  @override
  State<drawer2> createState() => _drawer2State();
}

class _drawer2State extends State<drawer2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drawer2')),
      body: Center(
        child: Text('con ga con'),
      ),
    );
  }
}
