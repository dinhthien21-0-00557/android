import 'package:flutter/material.dart';
import 'package:ktdk_tran_duc_thien/ui/app_menu.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  String currentPassword = '';
  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Setting'),
      ),
      drawer: const App_Menu(),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.deepPurple),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        currentPassword = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        newPassword = value;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const App_Menu(),
                        ),
                      );
                    },
                    child: Text('Change Password'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
