import 'package:flutter/material.dart';

class achievements extends StatefulWidget {
  const achievements({super.key});

  @override
  State<achievements> createState() => _achievementsState();
}

class _achievementsState extends State<achievements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 198, 212, 0),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                'assets/imges/thanhtuu.png',
                width: 120,
                height: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Table(
                border: TableBorder.all(
                    color: const Color.fromARGB(255, 176, 199, 0)),
                children: const [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Thành Tích'),
                      ),
                      TableCell(
                        child: Text('Số Trận'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Win'),
                      ),
                      TableCell(
                        child: Text('6'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Lost'),
                      ),
                      TableCell(
                        child: Text('12'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
