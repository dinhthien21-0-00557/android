import 'package:cuoiky/ui/character/character.dart';
import 'package:cuoiky/ui/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController usernameController = TextEditingController();
  void postUsername(String username) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('name').add({
      'username': username,
    }).then((value) {
      print("Đã gửi thành công tên người dùng: $username");
    }).catchError((error) {
      print("Đã xảy ra lỗi khi gửi tên người dùng: $error");
    });

    // firestore.collection('name').get().then((snapshot) {
    //   List<DocumentSnapshot> documents = snapshot.docs;

    //   // Sắp xếp lại danh sách tài liệu theo thứ tự mới
    //   documents.sort((a, b) {
    //     Timestamp aTimestamp = a.get('timestamp');
    //     Timestamp bTimestamp = b.get('timestamp');
    //     return bTimestamp.compareTo(aTimestamp);
    //   });

    //   // Cập nhật lại thứ tự của tài liệu
    //   for (int i = 0; i < documents.length; i++) {
    //     DocumentReference documentReference = documents[i].reference;
    //     documentReference.update({'timestamp': i});
    //   }
    // });
  }

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
                  Provider.of<UserProvider>(context, listen: false)
                      .setUserName(username);
                  postUsername(username);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => character()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 54, 98),
                  onPrimary: Colors.white,
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
