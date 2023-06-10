import 'dart:math';
import 'package:cuoiky/main.dart';
import 'package:cuoiky/ui/achievements/achievements.dart';
import 'package:cuoiky/ui/end/end.dart';
import 'package:cuoiky/ui/play/play.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  double _volumeLevel = 0.5;
  String randomImage = 'assets/imges/Hello.png';
  String idImges = 'assets/imges/welcome.png';
  int idbot = 0;
  int idyou = 0;
  int finalendPoind = 3;
  TextEditingController endPoint = TextEditingController();
  String name = '';
  Future<void> _showSetting(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 0, 255, 212),
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
              Row(
                children: [
                  const Text('End Point'),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                        controller: endPoint,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'\d+')),
                        ],
                        decoration: const InputDecoration(
                          fillColor: Color.fromARGB(
                              155, 95, 173, 236), // Màu nền của TextField
                          filled: true,
                        )),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  int? number = int.tryParse(endPoint.text);
                  finalendPoind = number ?? 3;
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showWin(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(microseconds: 500000), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: const Color.fromARGB(102, 0, 0, 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/imges/win.png'),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showHoa(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(microseconds: 500000), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: const Color.fromARGB(115, 0, 182, 206),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/imges/hoa.png'),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showLost(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(microseconds: 500000), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: const Color.fromARGB(124, 182, 0, 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/imges/lost.png'),
            ],
          ),
        );
      },
    );
  }

  List<String> imageList = [
    'assets/imges/keoremove.png',
    'assets/imges/buaremove.png',
    'assets/imges/baoremove.png',
  ];

  // ignore: non_constant_identifier_names
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

  void idData() {
    setState(() {
      IDData idData = IDData(
        idBot: '$idbot',
        idYou: '$idyou',
      );
      Provider.of<GameIDData>(context, listen: false).setIDData(idData);
    });
  }

  void changePage() {
    if (idbot == finalendPoind) {
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const End()),
        (Route<dynamic> route) => false,
      );
      postID(name, idbot.toString(), idyou.toString());
    } else if (idyou == finalendPoind) {
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const End()),
        (Route<dynamic> route) => false,
      );
      postID(name, idbot.toString(), idyou.toString());
    } else {}
  }

  void postID(String username, String idbot, String idyou) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Timestamp currentTime = Timestamp.now();
    firestore
        .collection('game')
        .add({
          'username': username,
          'idbot': idbot,
          'idyou': idyou,
          'time': currentTime,
        })
        .then((value) {})
        .catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    CharacterData characterData =
        Provider.of<GameData>(context).selectedCharacter;
    NameData nameData = Provider.of<GameNameData>(context).selectedName;
    name = nameData.name;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 50, 90),
        leading: IconButton(
          color: const Color.fromARGB(255, 7, 10, 218),
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Play()),
              (Route<dynamic> route) => route.isFirst,
            );
          },
        ),
        actions: [
          IconButton(
            color: const Color.fromARGB(255, 0, 255, 213),
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
                    builder: (BuildContext context) => const Game()),
                (Route<dynamic> route) => route.isFirst,
              );
            },
            icon: const Icon(Icons.restart_alt),
          ),
          IconButton(
            color: const Color.fromARGB(255, 212, 255, 0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Achievements()),
              );
            },
            icon: const Icon(Icons.verified),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromARGB(255, 0, 37, 67),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 10.0,
              child: Text(
                '0$idbot',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 120.0,
              child: Image(
                image: AssetImage(characterData.character),
                width: 150,
                height: 150,
              ),
            ),
            Positioned(
              bottom: 10.0,
              child: Text(
                '0$idyou',
                style: const TextStyle(
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
                      idImges = 'assets/imges/keoremove.png';
                      if (randomImage == 'assets/imges/buaremove.png') {
                        idbot++;
                        _showLost(context);

                        changePage();
                      } else if (randomImage == 'assets/imges/baoremove.png') {
                        idyou++;
                        _showWin(context);

                        changePage();
                      } else {
                        _showHoa(context);
                      }
                      idData();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(5),
                      backgroundColor: const Color.fromARGB(61, 158, 194, 224),
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
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(5),
                      backgroundColor: const Color.fromARGB(61, 158, 194, 224),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      onPressedButton();
                      changeImage();
                      idImges = 'assets/imges/buaremove.png';
                      if (randomImage == 'assets/imges/baoremove.png') {
                        idbot++;
                        _showLost(context);

                        changePage();
                      } else if (randomImage == 'assets/imges/keoremove.png') {
                        idyou++;
                        _showWin(context);

                        changePage();
                      } else {
                        _showHoa(context);
                      }
                      idData();
                    },
                    child: const Image(
                      image: AssetImage('assets/imges/bua.png'),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onPressedButton();
                      changeImage();
                      idImges = 'assets/imges/baoremove.png';
                      if (randomImage == 'assets/imges/keoremove.png') {
                        idbot++;
                        _showLost(context);

                        changePage();
                      } else if (randomImage == 'assets/imges/buaremove.png') {
                        idyou++;
                        _showWin(context);

                        changePage();
                      } else {
                        _showHoa(context);
                      }
                      idData();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(5),
                      backgroundColor: const Color.fromARGB(61, 158, 194, 224),
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
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 30),
                  Image(
                    image: AssetImage(idImges),
                    width: 200,
                    height: 200,
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
