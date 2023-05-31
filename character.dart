import 'package:flutter/material.dart';

class character extends StatefulWidget {
  const character({super.key});

  @override
  State<character> createState() => _characterState();
}

class _characterState extends State<character> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full-screen Dialog Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imges/br.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/imges/doremon.jpg',
                    width: 100.0,
                    height: 50.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Button 1',
                    style: TextStyle(fontSize: 50.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/imges/keo.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Button 2',
                    style: TextStyle(fontSize: 50.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/imges/keo.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Button 3',
                    style: TextStyle(fontSize: 50.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
