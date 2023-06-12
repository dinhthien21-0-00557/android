import 'package:cuoiky/main.dart';
import 'package:cuoiky/ui/character/character.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.all(50),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imges/br.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.blue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 188, 245),
                    ),
                  ),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 54, 101, 244),
                  ),
                  hintText: 'username',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 4, 238, 195),
                  ),
                ),
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 254, 216),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 80,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  String username = usernameController.text;
                  NameData nameData = NameData(name: username);
                  Provider.of<GameNameData>(context, listen: false)
                      .setNameData(nameData);
                  // postUsername(username);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Character()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 0, 54, 98),
                ),
                child: const Text(
                  'Play',
                  style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 1, 204, 255)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
