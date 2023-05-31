import 'package:cuoiky/main.dart';
import 'package:cuoiky/ui/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class character extends StatefulWidget {
  const character({super.key});

  @override
  State<character> createState() => _characterState();
}

class _characterState extends State<character> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
            SizedBox(
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {
                CharacterData characterData = CharacterData(
                  character: 'assets/imges/nu.png',
                );
                Provider.of<GameData>(context, listen: false)
                    .setCharacterData(characterData);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Welcome()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 5.0,
                ),
                backgroundColor: Color.fromARGB(74, 108, 108, 108),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/imges/nu.png',
                    width: 190,
                    height: 170,
                  ),
                  Text(
                    'Character 1',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                CharacterData characterData = CharacterData(
                  character: 'assets/imges/nam.png',
                );
                Provider.of<GameData>(context, listen: false)
                    .setCharacterData(characterData);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Welcome()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 5.0,
                ),
                backgroundColor: Color.fromARGB(74, 108, 108, 108),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/imges/nam.png',
                    width: 190,
                    height: 170,
                  ),
                  Text(
                    'Character 2',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                CharacterData characterData = CharacterData(
                  character: 'assets/imges/be.png',
                );
                Provider.of<GameData>(context, listen: false)
                    .setCharacterData(characterData);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Welcome()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 5.0,
                ),
                backgroundColor: Color.fromARGB(74, 108, 108, 108),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/imges/be.png',
                    width: 190,
                    height: 170,
                  ),
                  Text(
                    'Character 3',
                    style: TextStyle(fontSize: 30.0),
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
