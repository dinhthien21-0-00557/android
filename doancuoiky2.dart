import 'package:flutter/material.dart';

class cuoiki extends StatefulWidget {
  const cuoiki({super.key});

  @override
  State<cuoiki> createState() => _cuoikiState();
}

class _cuoikiState extends State<cuoiki> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kéo Búa Bao'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imges/brrrrr.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Play',
              style: TextStyle(
                  fontSize: 60, color: Color.fromARGB(255, 50, 159, 192)),
            ),
            IconButton(
              color: const Color.fromARGB(255, 7, 10, 218),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ()),
                );
              },
              icon: const Icon(Icons.play_circle),
              iconSize: 100,
            ),
          ],
        ),
      ),
    );
  }
}
