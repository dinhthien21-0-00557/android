import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class End extends StatefulWidget {
  const End({Key? key}) : super(key: key);

  @override
  State<End> createState() => _EndState();
}

class UserProvider extends ChangeNotifier {
  String? idbottext;

  String? idyoutext;

  void setIdbotText(String idbotText) {
    idbottext = idbotText;
    notifyListeners();
  }

  void setIdypuText(String idyouText) {
    idyoutext = idyouText;
    notifyListeners();
  }
}

class _EndState extends State<End> {
  String? get idbottext => Provider.of<UserProvider>(context).idbottext;
  String? get idyoutext => Provider.of<UserProvider>(context).idyoutext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imges/brend.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 20,
                top: 15,
                child: Image(
                  image: AssetImage('assets/imges/end.png'),
                  width: 350,
                  height: 350,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/imges/win.png'),
                      width: 50,
                      height: 50,
                    ),
                    Text(idyoutext!)
                  ],
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/imges/lost.png'),
                      width: 50,
                      height: 50,
                    ),
                    Text(idbottext!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
