import 'package:cuoiky/ui/character/character.dart';
import 'package:cuoiky/ui/play/play.dart';
import 'package:cuoiky/ui/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => GameData(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: play(),
    );
  }
}

class GameData extends ChangeNotifier {
  CharacterData _selectedCharacter = CharacterData(
    character: '',
  );

  CharacterData get selectedCharacter => _selectedCharacter;

  void setCharacterData(CharacterData characterData) {
    _selectedCharacter = characterData;
    notifyListeners();
  }
}

class CharacterData {
  final String character;

  CharacterData({required this.character});
}
