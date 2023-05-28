import 'package:flutter/material.dart';
import 'package:mvvm_sqlite_demo/menu/major2.dart';
import 'package:mvvm_sqlite_demo/ui/baitap/setting.dart';
import 'package:mvvm_sqlite_demo/ui/baitap/students.dart';
import 'package:path/path.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drawer Demo')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 3, 132, 244)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dinh Thien',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
                leading: const Icon(Icons.people),
                title: const Text("Students"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => students()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.menu),
                title: const Text("menu"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => drawer2()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("setting"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settings()),
                  );
                }),
          ],
        ),
      ),
      body: const Center(),
    );
  }
}
