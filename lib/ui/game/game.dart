import 'dart:math';

import 'package:cuoiky/ui/achievements/achievements.dart';
import 'package:cuoiky/ui/play/play.dart';
import 'package:flutter/material.dart';

class game extends StatefulWidget {
  const game({super.key});

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  double _volumeLevel = 0.5;
  String randomImage = 'assets/imges/tom.png';
  String idImges = 'assets/imges/tom.png';
  Future<void> _showSetting(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text('Setting'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.volume_down),
                  Expanded(
                    child: Slider(
                      value: _volumeLevel,
                      min: 0,
                      max: 1,
                      onChanged: (newValue) {
                        setState(() {
                          _volumeLevel = newValue;
                        });
                      },
                      onChangeEnd: (newValue) {
                        setState(() {
                          Navigator.of(context).pop();
                          _showSetting(context);
                        });
                      },
                    ),
                  ),
                  const Icon(Icons.volume_up),
                ],
              ),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<String> imageList = [
    'assets/imges/keo.png',
    'assets/imges/bua.png',
    'assets/imges/bao.png',
  ];

  String RandomImage() {
    final random = Random();
    final randomIndex = random.nextInt(imageList.length);
    final randomURL = imageList[randomIndex];
    return randomURL;
  }

  void onPressedButton() {
    setState(() {
      randomImage = RandomImage();
    });
  }

  void changeImage() {
    setState(() {
      idImges = 'assets/imges/bao.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 50, 90),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const play()),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showSetting(context);
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const game()),
                (Route<dynamic> route) => route.isFirst,
              );
            },
            icon: const Icon(Icons.restart_alt),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const achievements()),
              );
            },
            icon: const Icon(Icons.verified),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Color.fromARGB(255, 0, 37, 67),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 10.0,
              child: Text(
                '00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 120.0,
              child: Image(
                image: AssetImage('assets/imges/tom.png'),
                width: 150,
                height: 150,
              ),
            ),
            Positioned(
              bottom: 10.0,
              child: Text(
                '00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 50.0,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      onPressedButton();
                      changeImage();
                      idImges = 'assets/imges/keo.png';
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      backgroundColor: Color.fromARGB(61, 158, 194, 224),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Image(
                      image: AssetImage('assets/imges/keo.png'),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      backgroundColor: Color.fromARGB(61, 158, 194, 224),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      onPressedButton();
                      changeImage();
                      idImges = 'assets/imges/bua.png';
                    },
                    child: Image(
                      image: AssetImage('assets/imges/bua.png'),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onPressedButton();
                      changeImage();
                      idImges = 'assets/imges/bao.png';
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      backgroundColor: Color.fromARGB(61, 158, 194, 224),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Image(
                      image: AssetImage('assets/imges/bao.png'),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(randomImage),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 50),
                  Image(
                    image: AssetImage(idImges),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
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
