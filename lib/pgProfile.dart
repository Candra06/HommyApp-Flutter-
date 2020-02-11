import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hommy_app/pg_login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'auth/autentication.dart';

class ProfileSide extends StatefulWidget {
  @override
  _ProfileSideState createState() => _ProfileSideState();
}

class _ProfileSideState extends State<ProfileSide> {
  Map data;
  String nama = "";
  String email = "";
  String hp = "";

  Future getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString('email');
      nama = pref.getString('nama');
      hp = pref.getString('email');
    });
    print(email);
    print(nama);
    print(hp);
  }

  Future logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.Response res = await http.post(url + "api/logout",
        headers: {'Authorization': pref.getString('auth')});
    data = jsonDecode(res.body);
    setState(() {
      if (res.statusCode == 200) {
        pref.setBool("isLogin", false);
        pref.setString("nama", null);
        pref.setString("auth", null);
        pref.setString("email", null);
        pref.setString("id", null);
        Navigator.of(context).pushReplacement(new PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(seconds: 1),
            child: LoginPage()));
      }
      // data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/backdash.png'),
                      fit: BoxFit.cover)),
              child: Expanded(
                child: Container(),
              ),
            ),
            Positioned(
              top: 148,
              left: 20,
              right: 20,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Text(
                          nama,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.pink),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Icon(
                            Icons.email,
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(color: Colors.black87),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Icon(
                            Icons.phone,
                            color: Colors.black45,
                          ),
                        ),
                        Text(hp, style: TextStyle(color: Colors.black87))
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        logOut();
                      },
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                            child: Icon(
                              Icons.exit_to_app,
                              color: Colors.pink,
                            ),
                          ),
                          Text('Logout', style: TextStyle(color: Colors.pink))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width * 1 / 3,
              right: MediaQuery.of(context).size.width * 1 / 3,
              child: new ClipRRect(
                borderRadius: new BorderRadius.circular(50.0),
                child: Image.network(
                  'http://sirmb.evoindo.com/assets/dist/img/user2-160x160.jpg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            //   child: Column(
            //     children: <Widget>[
            //       Center(
            //         child: Text('User'),
            //       )
            //     ],
            //   ),
            // )
          ],
        ));
  }
}
