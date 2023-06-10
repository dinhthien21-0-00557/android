import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AchievementsState createState() => _AchievementsState();
}

CollectionReference<Map<String, dynamic>> _gameCollection =
    FirebaseFirestore.instance.collection('game');

class _AchievementsState extends State<Achievements> {
  final TextEditingController _passwordController = TextEditingController();
  Future<void> _showDelete(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Password'),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              if (_passwordController.text == 'adminDelete') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Achievements'),
                      content: const Text(
                          'When you tap on it, it will clear all data of the Achievements page.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            _gameCollection.get().then((snapshot) {
                              for (var doc in snapshot.docs) {
                                doc.reference.delete();
                              }
                            });

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Achievements()),
                              (Route<dynamic> route) => route.isFirst,
                            );
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error*'),
                      content:
                          const Text('Incorrect password. Please try again.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            decoration: const InputDecoration(
              hintText: 'Pasword',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String password = _passwordController.text;
                if (password == 'adminDelete') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Achievements'),
                        content: const Text(
                            'When you tap on it, it will clear all data of the Achievements page.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              _gameCollection.get().then((snapshot) {
                                for (var doc in snapshot.docs) {
                                  doc.reference.delete();
                                }
                              });

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Achievements()),
                                (Route<dynamic> route) => route.isFirst,
                              );
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error*'),
                        content:
                            const Text('Incorrect password. Please try again.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Confirm'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Achievements()),
                  (Route<dynamic> route) => route.isFirst,
                );
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(155, 0, 157, 255),
        leading: IconButton(
          color: const Color.fromARGB(255, 255, 0, 0),
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            color: const Color.fromARGB(255, 0, 0, 0),
            onPressed: () {
              _showDelete(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imges/br_achievements.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Thành Tựu',
                  style: TextStyle(
                    fontSize: 50,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 242, 255, 0),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 25, 0, 250),
                        offset: Offset(10, 10),
                        blurRadius: 50,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _gameCollection
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, gameSnapshot) {
                    if (gameSnapshot.hasError) {
                      return Text('Lỗi: ${gameSnapshot.error}');
                    }

                    if (gameSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    // Xử lý dữ liệu từ gameSnapshot và lấy danh sách các idBot và idYou
                    List<String?> idBots = gameSnapshot.data!.docs.map((doc) {
                      return doc.get('idbot').toString();
                    }).toList();

                    List<String?> idYous = gameSnapshot.data!.docs.map((doc) {
                      return doc.get('idyou').toString();
                    }).toList();
                    List<String> usernames = gameSnapshot.data!.docs.map((doc) {
                      return doc.get('username') as String;
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
                      String? idYou = idYous[index];
                      String? idBot = idBots[index];

                      return DataRow(cells: [
                        DataCell(Text(
                          username,
                          style: const TextStyle(
                              color: Color.fromRGBO(200, 0, 239, 1),
                              fontSize: 18),
                        )),
                        DataCell(Text(
                          idYou.toString(),
                          style: const TextStyle(
                              color: Color.fromRGBO(200, 0, 239, 1),
                              fontSize: 18),
                        )),
                        DataCell(Text(
                          idBot.toString(),
                          style: const TextStyle(
                              color: Color.fromRGBO(200, 0, 239, 1),
                              fontSize: 18),
                        )),
                      ]);
                    });

                    // Tạo bảng chung
                    Widget achievementsTable = DataTable(
                      border: TableBorder.all(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: const Color.fromARGB(255, 0, 255, 251)),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 172, 252, 213),
                          borderRadius: BorderRadius.circular(10)),
                      columns: const [
                        DataColumn(
                            label: Text(
                          'Username',
                          style: TextStyle(
                              color: Color.fromRGBO(200, 0, 239, 1),
                              fontSize: 18),
                        )),
                        DataColumn(
                            label: Text(
                          'Win',
                          style: TextStyle(
                              color: Color.fromRGBO(200, 0, 239, 1),
                              fontSize: 18),
                        )),
                        DataColumn(
                            label: Text(
                          'Lost',
                          style: TextStyle(
                              color: Color.fromRGBO(200, 0, 239, 1),
                              fontSize: 18),
                        )),
                      ],
                      rows: dataRows,
                    );

                    // Hiển thị bảng thành tựu chung
                    return achievementsTable;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
