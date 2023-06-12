import 'package:cuoiky/ui/play/play.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => GameNameData(),
    ),
    ChangeNotifierProvider(
      create: (context) => GameData(),
    ),
    ChangeNotifierProvider(
      create: (context) => GameIDData(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Play(),
    );
  }
}

//GameData
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

//GameIDData
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

  void setNameData(NameData nameData) {}
}

class IDData {
  final String idBot;
  final String idYou;

  IDData({required this.idBot, required this.idYou});
}

//NameData
class GameNameData extends ChangeNotifier {
  NameData _selectedName = NameData(
    name: '',
  );

  NameData get selectedName => _selectedName;

  void setNameData(NameData nameData) {
    _selectedName = nameData;
    notifyListeners();
  }
}

class NameData {
  final String name;

  NameData({required this.name});
}
