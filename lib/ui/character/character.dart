import 'package:flutter/material.dart';

class characterScreen extends StatelessWidget {
  characterScreen({Key? key}) : super(key: key);

  final List<String> characters = [
    'Character 1',
    'Character 2',
    'Character 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character Selection'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(characters[index]),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
