import 'dart:convert';
import 'package:hommy_app/Validasi/TextValidation.dart';
import 'package:hommy_app/Validasi/TextValidation.dart';
import 'package:flutter/material.dart';
import 'package:hommy_app/pg_dashboard.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'auth/autentication.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  final String layanan;

  OrderPage({Key key,this.layanan}) : super(key: key);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  String nama;
  String email;
  String id;
  DateTime now = DateTime.now();
  String tanggal ;
  String token ;

  Map data;

  final _key = new GlobalKey<FormState>();

  final TextEditingController alamat = new TextEditingController();


  Future getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('auth');
      nama = pref.getString('nama');
      email = pref.getString('email');
      id = pref.getString('id');
      print(tanggal);
    });
  }

  clear() {
    alamat.text = "";
    id = "";
    nama = "";
    email = "";
    
  }

  Future order() async {
    tanggal = DateFormat('yyyy-MM-dd').format(now);
    http.Response res = await http.post(url+'api/order', body: {
      'id_user' : id,
      'service' : "${widget.layanan}",
      'address' : alamat.text,
      'date' : tanggal
    }, headers: { 'Authorization': 'Bearer $token', });
    data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          setState(() {
            // Navigator.pop(context);
            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, duration: Duration(seconds: 1), child: HomePage()));
            clear();
          });
          
          // Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Pesan"),
        content: Text("Pemesanan layanan berhasil!"),
        actions: [
          okButton,
          
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            constraints: BoxConstraints(minWidth: 400, maxWidth: double.infinity),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BackOrder.png'),
                fit: BoxFit.cover
              )
            ),
            child: SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 30,),
                Center(
                  child: Text('Pemesanan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Roboto', color: Colors.black), ),
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.person, size: 29, color: Colors.black54,),
                              SizedBox(width: 10,),
                              Text(nama == null ? 'waiting...' : nama, style: TextStyle(fontSize: 18),)
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.phone, size: 29, color: Colors.black54,),
                              SizedBox(width: 10,),
                              Text(email == null ? 'waiting...' : email, style: TextStyle(fontSize: 18),)
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.build, size: 29, color: Colors.black54,),
                              SizedBox(width: 10,),
                              Text("${widget.layanan}", style: TextStyle(fontSize: 18),)
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Alamat tidak boleh kosong';
                              }
                              return null;
                            },
                            controller: alamat,
                            decoration: InputDecoration(
                              labelText: "Alamat",
                              icon: Icon(Icons.home, size: 30, color: Colors.black54,),
                              labelStyle: TextStyle(color: Colors.pinkAccent),
                                hintText: "Masukkan Alamat",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pinkAccent)
                                )
                            ),
                            keyboardType: TextInputType.multiline,
                          )
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            color: Colors.pinkAccent,
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text('PESAN', style: TextStyle(color: Colors.white),),
                            splashColor: Colors.pink,
                            onPressed: () {
                              if (_key.currentState.validate()) {
                                order();
                              }
                              
                            },
                          )
                        )
                    ],
                  ),
                )
              ],
            ),
            )
          ),
        )
      ),
    );
  }
}