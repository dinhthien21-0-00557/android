import 'dart:async';

import 'package:cuoiky/ui/game/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class UserProvider extends ChangeNotifier {
  String? username;

  void setUserName(String name) {
    username = name;
    notifyListeners();
  }
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => game()),
      );
    });
  }

  Widget build(BuildContext context) {
    String? username = Provider.of<UserProvider>(context).username;

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
              image: AssetImage('assets/imges/br.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                """ Welcome 
   $username""",
                style: TextStyle(
                  fontSize: 70,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 0, 255, 204),
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 25, 0, 250),
                      offset: Offset(10, 10),
                      blurRadius: 50,
                    ),
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
