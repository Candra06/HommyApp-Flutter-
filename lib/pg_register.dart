import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hommy_app/Validasi/TextValidation.dart';
import 'package:hommy_app/auth/autentication.dart';
// import 'package:hommy_app/pg_dashboard.dart';
import 'pg_login.dart';
import 'package:page_transition/page_transition.dart';
import 'Animations/fade_animation.dart';
import 'Validasi/TextValidation.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    )
  );
}
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Validasi{

  final _formKey = GlobalKey<FormState>();

  bool hasil;

  final TextEditingController txtnama = new TextEditingController();
  final TextEditingController txtemail = new TextEditingController();
  final TextEditingController txtpassword = new TextEditingController();
  final TextEditingController txtconfPassword = new TextEditingController();
  final TextEditingController txtnoHP = new TextEditingController();

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
          child: Container(
            margin: EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: new Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(1, 
                            Text("REGISTER", 
                              style: TextStyle(
                                        fontSize: 35, 
                                        fontWeight: FontWeight.w800, 
                                        color: Colors.pinkAccent))
                            ),
                          FadeAnimation(1.3, 
                            TextFormField(
                              decoration: InputDecoration(
                              labelText: "Nama",
                              labelStyle: TextStyle(color: Colors.pinkAccent),
                              hintText: "Masukkan Nama",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.pinkAccent)
                              )
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Nama harus diisi!';
                              }
                              return null;
                            },
                            controller: txtnama,
                            )
                          ),
                          FadeAnimation(1.3, 
                            TextFormField(
                              decoration: InputDecoration(
                              labelText: "Nomor HP",
                              labelStyle: TextStyle(color: Colors.pinkAccent),
                              hintText: "Masukkan Nomor HP ex. 08..",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.pinkAccent)
                              )
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Nomor HP harus diisi!';
                              }
                              return null;
                            },
                            controller: txtnoHP,
                            )
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
                            validator: (value) {
                              if (!value.contains('@')) {
                                return 'Email tidak valid!';
                              }
                              return null;
                            },
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
                            validator: (val) {
                              if (val.length < 4) {
                                return 'Password minimal 4 karakter!';
                              }
                              return null;
                            },
                            controller: txtpassword,
                            )
                          ),
                          FadeAnimation(1.9, 
                            TextFormField(
                              decoration: InputDecoration(
                              labelText: "Konfirmasi Password",
                              labelStyle: TextStyle(color: Colors.pinkAccent),
                              hintText: "Masukkan Ulang Password",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.pinkAccent)
                              )
                            ),
                            obscureText: true,
                            validator: (val) {
                              if (val.isEmpty && val.length < 4) {
                                return 'Password minimal 4 karakter!';
                              }else if (val.toString() != txtpassword.text) {
                                return 'Password tidak sama!';
                              }
                              return null;
                            },
                            controller: txtconfPassword,
                            )
                          ),
                          SizedBox(height: 10.0,),
                        ],
                      ),
                    ),
                    FadeAnimation(2.2, 
                      Container(
                      child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(minWidth: 100, maxWidth: 250),
                              padding: EdgeInsets.only(left: 20,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Sudah memiliki akun? ', style: TextStyle(fontSize: 16),),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Login', style: TextStyle(color: Colors.pink, fontSize: 16, fontWeight: FontWeight.bold), 
                                    textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          // color: Colors.blueAccent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                                color: Colors.pinkAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                textColor: Colors.white,
                                child:Text('Daftar'),
                                onPressed: () async{

                                  SnackBar failed = SnackBar(
                                    content: Text('Register gagal!'),
                                      duration: Duration(seconds: 10),
                                      backgroundColor: Colors.red[900],
                                      action: SnackBarAction(
                                        label: 'Oke', 
                                        onPressed: () async{
                                          Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: Duration(seconds: 1), child: RegisterPage()));
                                        }),
                                  );

                                  SnackBar success = SnackBar(
                                    content: Text('Register berhasil!'),
                                      duration: Duration(seconds: 10),
                                      backgroundColor: Colors.green,
                                      action: SnackBarAction(
                                        label: 'Oke', 
                                        onPressed: () async{
                                          Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: Duration(seconds: 1), child: LoginPage()));
                                        }),
                                  );

                                  if (_formKey.currentState.validate()) {
                                    final respon = await http.post(url+"api/daftar", body: {
                                        "name" : txtnama.text,
                                        "email" : txtemail.text,
                                        "password" : txtpassword.text,
                                        "c_password" : txtconfPassword.text,
                                        "handphone" : txtnoHP.text,
                                        "address" : '-'
                                      });
                                      print(respon.body);
                                      final data = jsonDecode(respon.body);
                                      print(data['error']);
                                      print(respon.statusCode);
                                      if (data['error'] == 'Email sudah terdaftar!' || data['error'] == 'No Handphone sudah terdaftar!' ) {
                                        Scaffold.of(context).showSnackBar(failed);
                                      } else if (respon.statusCode != 200) {
                                        Scaffold.of(context).showSnackBar(failed);
                                      }else if(respon.statusCode == 200 && data['message'] == 'Berhasil Mendaftar!'){
                                        Scaffold.of(context).showSnackBar(success);
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
            )
          )
          
        );
        })
        
      ),
      
    );
  }
}