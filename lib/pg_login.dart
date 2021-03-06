import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hommy_app/Validasi/TextValidation.dart';
import 'package:hommy_app/auth/autentication.dart';
import 'package:hommy_app/pg_dashboard.dart';
import 'package:hommy_app/pg_register.dart';
import 'package:page_transition/page_transition.dart';
import 'Animations/fade_animation.dart';
import 'Validasi/TextValidation.dart';
import 'Animations/TransitionEnter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    )
  );
}
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Validasi{

  final _key = new GlobalKey<FormState>();
  Map data;
  List response;
  bool login;

  final TextEditingController txtemail = new TextEditingController();
  final TextEditingController txtpassword = new TextEditingController();

  Future setValue() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("isLogin") ?? false;
  }

  Future _cekLogin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    
    if (pref.getString("nama") != null || pref.getString("auth") != null) {
      setState(() {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: Duration(seconds: 1), child: HomePage()));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _cekLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(builder: (context) {
          return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BackLogin.png'),
                  fit: BoxFit.cover
            )
          ),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(1, 
                        Text("SIGN IN", 
                          style: TextStyle(
                                    fontSize: 35, 
                                    fontWeight: FontWeight.w800, 
                                    color: Colors.pinkAccent))
                        ),
                      FadeAnimation(1.3, 
                        TextFormField(
                          decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.pinkAccent),
                          hintText: "Masukkan Email",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent)
                          )
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: validasiEmail,
                        controller: txtemail,
                        )
                      ),
                      FadeAnimation(1.6, 
                        TextFormField(
                          decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.pinkAccent),
                          hintText: "Masukkan Password",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent)
                          )
                        ),
                        obscureText: true,
                        validator: validasiPassword,
                        controller: txtpassword,
                        )
                      ),
                      SizedBox(height: 40.0,),
                    ],
                  ),
                ),
                FadeAnimation(1.9, 
                  Container(
                  child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Belum memiliki akun? ', style: TextStyle(fontSize: 16),),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, EnterExit(exitPage: LoginPage(), enterPage: RegisterPage()));
                                },
                                child: Text('Daftar', style: TextStyle(color: Colors.pink, fontSize: 16, fontWeight: FontWeight.bold), 
                                textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      // color: Colors.blueAccent,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                            color: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            textColor: Colors.white,
                            child:Text('Masuk'),
                            onPressed: () async{
                              SnackBar snackBar = SnackBar(
                                content: Text('Login gagal!', style: TextStyle(color: Colors.black),),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.white,
                                  action: SnackBarAction(
                                    label: 'Oke', 
                                    onPressed: () async{
                                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: Duration(seconds: 1), child: LoginPage()));
                                    }),
                              );

                              SnackBar success = SnackBar(
                                content: Text('Login berhasil!'),
                                duration: Duration(seconds: 10),
                                backgroundColor: Colors.green,
                                action: SnackBarAction(
                                  label: 'Oke', 
                                  onPressed: () async{
                                    SharedPreferences pref = await SharedPreferences.getInstance();
                                    pref.setBool("isLogin", true);
                                    pref.setString("auth", data["data"]["token"]);
                                    pref.setString("nama", data["data"]["name"]);
                                    pref.setString("email", data["data"]["email"]);
                                    pref.setString("id", data["data"]["id"]);
                                    pref.setString("hp", data["data"]["handphone"]);
                                    login =pref.getBool("isLogin");
                                    Navigator.of(context).pushReplacement(new PageTransition(type: PageTransitionType.fade, duration: Duration(seconds: 1), child: HomePage()));
                                  }),
                                );
                              if (_key.currentState.validate()) {
                                http.Response respon = await http.post(url+"api/login", body: {
                                  "email" : txtemail.text,
                                  "password" : txtpassword.text
                                });
                                print(respon.body);
                                data = jsonDecode(respon.body);
                                if (respon.statusCode == 200) {
                                  // Scaffold.of(context).showSnackBar(success);
                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                    pref.setBool("isLogin", true);
                                    pref.setString("auth", data["data"]["token"]);
                                    pref.setString("nama", data["data"]["name"]);
                                    pref.setString("email", data["data"]["email"]);
                                    pref.setString("id", data["data"]["id"]);
                                    pref.setString("hp", data["data"]["handphone"]);
                                    login =pref.getBool("isLogin");
                                    Navigator.of(context).pushReplacement(new PageTransition(type: PageTransitionType.fade, duration: Duration(seconds: 1), child: HomePage()));
                                } else {
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                              }
                            },
                          ),
                    ),
                      ),
                  ],
                ),
                )
                )
                
              ],
            ),
          )
          
        );
        })
        
      ),
      
    );
  }

  void showSnackbar(BuildContext context){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Login gagal!'),
        action: SnackBarAction(label: 'Oke', onPressed: (){}),
        )
    );
  }
}