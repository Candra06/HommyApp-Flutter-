// import 'dart:convert';

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
      hp = pref.getString('hp');
    });
  }

  Future logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.Response res = await http.post(url + "api/logout",
        headers: {'Authorization': 'Bearer ' + pref.getString('auth')});
    print(res.body);
    print(pref.getString('auth'));
    // data = jsonDecode(res.body);
    setState(() {
      if (res.statusCode == 200) {
        pref.setBool("isLogin", false);
        pref.setString("nama", null);
        pref.setString("auth", null);
        pref.setString("email", null);
        pref.setString("id", null);
        pref.setString("hp", null);
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
    return  Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black12,
          body: Stack(
            children: <Widget>[
              Image.asset('assets/images/backdash.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,),
              
              Container(
                alignment: FractionalOffset.center,
                child: Stack(
                  children:<Widget>[
                    
                    Container(
                          padding: EdgeInsets.only(top: 55),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                      margin: EdgeInsets.only(left: 16, right: 16),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: new Column(
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
                          ),
                          SizedBox(height: 40),
                          Center(
                            child: Text('2020 \u00a9 Copyright by PrimaInovasiTeknologi', style: TextStyle(color: Colors.black45),)
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 1/3,
                    right: MediaQuery.of(context).size.width * 1/3,
                      child: Container(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                          backgroundColor: Colors.transparent,
                        ),
                      )),
                  ] 
                ),
              )
            ],
          )
    );
  }

}
