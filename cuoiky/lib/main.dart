import 'package:cuoiky/ui/character/character.dart';
import 'package:cuoiky/ui/play/play.dart';
import 'package:cuoiky/ui/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => GameData(),
    ),
    ChangeNotifierProvider(
      create: (context) => GameIDData(),
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

class GameIDData extends ChangeNotifier {
  IDData _selectedID = IDData(
    idBot: '',
    idYou: '',
  );

  IDData get selectedID => _selectedID;

  void setIDData(IDData idData) {
    _selectedID = idData;
    notifyListeners();
  }
}

class IDData {
  final String idBot;
  final String idYou;

  IDData({required this.idBot, required this.idYou});
}
