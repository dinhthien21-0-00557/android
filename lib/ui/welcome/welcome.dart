import 'dart:async';

import 'package:cuoiky/ui/game/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class UserProvider extends ChangeNotifier {
  String? username;

  void setUserName(String name) {
    username = name;
    notifyListeners();
  }
}

class _welcomeState extends State<welcome> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
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
            Center(
              child: Text(
                'Welcome, $username!',
                style: TextStyle(
                    fontSize: 50, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
