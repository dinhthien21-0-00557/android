import 'dart:math';
import 'package:cuoiky/main.dart';
import 'package:cuoiky/ui/achievements/achievements.dart';
import 'package:cuoiky/ui/end/end.dart';
import 'package:cuoiky/ui/play/play.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class game extends StatefulWidget {
  const game({Key? key}) : super(key: key);

  @override
  State<game> createState() => _gameState();
}

class UserProvider extends ChangeNotifier {
  String? username;

  void setUserName(String name) {
    username = name;
    notifyListeners();
  }
}

class _gameState extends State<game> {
  double _volumeLevel = 0.5;
  String randomImage = 'assets/imges/Hello.png';
  String idImges = 'assets/imges/welcome.png';
  int idbot = 0;
  int idyou = 0;
  int finalendPoind = 3;
  TextEditingController endPoint = TextEditingController();

  Future<void> _showSetting(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 0, 255, 212),
          title: Center(
            child: Text('Setting'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.volume_down),
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
                  Icon(Icons.volume_up),
                ],
              ),
              Row(
                children: [
                  Text('End Point'),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                        controller: endPoint,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'\d+')),
                        ],
                        decoration: InputDecoration(
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
                child: Text('Save'),
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
        Future.delayed(Duration(microseconds: 500000), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: Color.fromARGB(102, 0, 0, 0),
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
        Future.delayed(Duration(microseconds: 500000), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: Color.fromARGB(115, 0, 182, 206),
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
        Future.delayed(Duration(microseconds: 500000), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: Color.fromARGB(124, 182, 0, 0),
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

  void changePage() {
    if (idbot == finalendPoind) {
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const End()),
        (Route<dynamic> route) => false,
      );
      postID(idbot, idyou);
    } else if (idyou == finalendPoind) {
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const End()),
        (Route<dynamic> route) => false,
      );
      postID(idbot, idyou);
    } else {}
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

  void postID(int idbot, int idyou) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('game').add({
      'idbot': idbot,
      'idyou': idyou,
    }).then((value) {
      print("Đã gửi thành công tên người dùng: $idbot $idyou");
    }).catchError((error) {
      print("Đã xảy ra lỗi khi gửi tên người dùng: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    CharacterData characterData =
        Provider.of<GameData>(context).selectedCharacter;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 50, 90),
        leading: IconButton(
          color: const Color.fromARGB(255, 7, 10, 218),
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const play()),
              (Route<dynamic> route) => route.isFirst,
            );
          },
        ),
        actions: [
          IconButton(
            color: Color.fromARGB(255, 0, 255, 213),
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
            color: Color.fromARGB(255, 212, 255, 0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => achievements()),
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
                '0$idbot',
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
                image: AssetImage('${characterData.character}'),
                width: 150,
                height: 150,
              ),
            ),
            Positioned(
              bottom: 10.0,
              child: Text(
                '0$idyou',
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
