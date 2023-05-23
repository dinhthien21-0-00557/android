import 'package:cuoiky/ui/game/game.dart';
import 'package:flutter/material.dart';

class play extends StatefulWidget {
  const play({super.key});

  @override
  State<play> createState() => _playState();
}

class _playState extends State<play> {
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
            image: AssetImage('assets/imges/br.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Play',
              style: TextStyle(
                  fontSize: 60, color: Color.fromARGB(255, 50, 159, 192)),
            ),
            IconButton(
              color: const Color.fromARGB(255, 7, 10, 218),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => game()),
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
