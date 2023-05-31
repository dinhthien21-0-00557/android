import 'package:cuoiky/ui/achievements/achievements.dart';
import 'package:cuoiky/ui/play/play.dart';
import 'package:flutter/material.dart';

class End extends StatefulWidget {
  const End({Key? key}) : super(key: key);

  @override
  State<End> createState() => _EndState();
}

class _EndState extends State<End> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imges/brend.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 20,
                top: 15,
                child: Image(
                  image: AssetImage('assets/imges/end.png'),
                  width: 350,
                  height: 350,
                ),
              ),
              Positioned(
                left: 0,
                top: 10,
                child: IconButton(
                  color: const Color.fromARGB(255, 7, 10, 218),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => play()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(Icons.play_circle),
                  iconSize: 40,
                ),
              ),
              Positioned(
                right: 0,
                top: 10,
                child: IconButton(
                  color: Color.fromARGB(255, 212, 255, 0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => achievements()),
                    );
                  },
                  icon: const Icon(Icons.verified),
                  iconSize: 40,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/imges/win.png'),
                      width: 50,
                      height: 50,
                    ),
                    Text('')
                  ],
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/imges/lost.png'),
                      width: 50,
                      height: 50,
                    ),
                    Text(''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
