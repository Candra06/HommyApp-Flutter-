import 'package:flutter/material.dart';
import 'package:hommy_app/pgProfile.dart';
import 'pgHome.dart';
import 'pgHistory.dart';
import 'pgProfile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  final pageOption = [
    HomeSide(),
    HistorySide(),
    ProfileSide(),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah anda yakin?'),
            content: new Text('Anda ingin keluar aplikasi?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Tidak'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Iya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: Scaffold(
          body: pageOption[selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedPage,
            onTap: (int index) {
              setState(() {
                selectedPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Beranda')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), title: Text('Riwayat')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profil')),
            ],
          ),
        ),
      ),
    );
  }
}
