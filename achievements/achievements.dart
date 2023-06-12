import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class achievements extends StatefulWidget {
  @override
  _achievementsState createState() => _achievementsState();
}

CollectionReference<Map<String, dynamic>> _usersCollection =
    FirebaseFirestore.instance.collection('name');
CollectionReference<Map<String, dynamic>> _gameCollection =
    FirebaseFirestore.instance.collection('game');

class _achievementsState extends State<achievements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thành tựu'),
        actions: [
          IconButton(
            onPressed: () {
              _usersCollection.get().then((snapshot) {
                for (var doc in snapshot.docs) {
                  doc.reference.delete();
                }
              });

              _gameCollection.get().then((snapshot) {
                for (var doc in snapshot.docs) {
                  doc.reference.delete();
                }
              });

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => achievements()),
                (Route<dynamic> route) => route.isFirst,
              );
            },
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Thành tựu chung'),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _usersCollection.snapshots(),
              builder: (context, usersSnapshot) {
                if (usersSnapshot.hasError) {
                  return Text('Lỗi: ${usersSnapshot.error}');
                }

                if (usersSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                // Xử lý dữ liệu từ usersSnapshot và lấy danh sách các username
                List<String> usernames = usersSnapshot.data!.docs.map((doc) {
                  return doc.get('username') as String;
                }).toList();

                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _gameCollection.snapshots(),
                  builder: (context, gameSnapshot) {
                    if (gameSnapshot.hasError) {
                      return Text('Lỗi: ${gameSnapshot.error}');
                    }

                    if (gameSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    // Xử lý dữ liệu từ gameSnapshot và lấy danh sách các idBot và idYou
                    List<int> idBots = gameSnapshot.data!.docs.map((doc) {
                      return doc.get('idbot') as int;
                    }).toList();

                    List<int> idYous = gameSnapshot.data!.docs.map((doc) {
                      return doc.get('idyou') as int;
                    }).toList();

                    // Xác định số hàng trong bảng
                    int rowCount = usernames.length;
                    if (idBots.length < rowCount) {
                      rowCount = idBots.length;
                    }
                    if (idYous.length < rowCount) {
                      rowCount = idYous.length;
                    }

                    // Tạo danh sách các DataRow
                    List<DataRow> dataRows =
                        List<DataRow>.generate(rowCount, (index) {
                      String username = usernames[index];
                      int idYou = idYous[index];
                      int idBot = idBots[index];

                      return DataRow(cells: [
                        DataCell(Text(username)),
                        DataCell(Text(idYou.toString())),
                        DataCell(Text(idBot.toString())),
                      ]);
                    });

                    // Tạo bảng chung
                    Widget achievementsTable = DataTable(
                      columns: [
                        DataColumn(label: Text('Tên người dùng')),
                        DataColumn(label: Text('Win')),
                        DataColumn(label: Text('Lost')),
                      ],
                      rows: dataRows,
                    );

                    // Hiển thị bảng thành tựu chung
                    return achievementsTable;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
