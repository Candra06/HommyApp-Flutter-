import 'package:flutter/material.dart';
import 'package:hommy_app/pg_detail.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:hommy_app/auth/autentication.dart';

class HistorySide extends StatefulWidget {
  @override
  _HistorySideState createState() => _HistorySideState();
}

class _HistorySideState extends State<HistorySide> {
  String token = "";
  String id = "";
  String title = "";
  
  Map<dynamic,dynamic> data;
  List<dynamic> listHistory;

  Future getData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('auth');
    http.Response response = await http.post(url+'api/order/list',  
      headers: { 'Authorization': 'Bearer $token', },
      body: {
        'id_user' : id,
      });
      print(response.body);
    data = jsonDecode(response.body);
    
    setState(() {
      listHistory = data["data"];
      print(listHistory);
    });
  }

  Widget convDate(String date) {
    DateTime tgl = DateTime.parse(date);
    String format = DateFormat("yyyy-MMM-d").format(tgl);
    var value= format.split('-');
    var dat = value[2];
    return Text('$dat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17));
  }

  Widget convMounth( String m){
    DateTime tgl = DateTime.parse(m);
    String format = DateFormat("yyyy-MMM-d").format(tgl);
    var value= format.split('-');
    var dat = value[1];
    return Text('$dat', style: TextStyle(fontSize: 13));
  }

  Future getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('auth');
      id = pref.getString('id');
    });
  }

@override
  void initState() {
    super.initState();
    getDataUser();
    getData();
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(251, 251, 251, 1),
        child: Padding(
          padding: EdgeInsets.all(10),
          child:listHistory == null ? Text('') :ListView.builder(
            itemCount: listHistory.length,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: DetailPesanan(idDetail: "${listHistory[index]['id_order']}",)));
                  });
                },
                child: Container(
                  decoration:new BoxDecoration(
                    color: Color.fromRGBO(238, 238, 238, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink[100],
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: Offset(0, 2)
                      )
                    ]
                  ),
                  
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: Colors.pinkAccent,
                        height: 60,
                        width: 5,
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: 200, maxWidth: 315),                  
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              height: 40,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              margin: EdgeInsets.fromLTRB(8, 1, 8, 1),
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Column(
                                children: <Widget>[
                                  convDate("${listHistory[index]['date']}"),
                                  convMounth("${listHistory[index]['date']}")
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${listHistory[index]['id_order']}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),),
                                  Text("${listHistory[index]['service']}", style: TextStyle( color: Colors.black54),)
                                ]
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ),
    );
  }
}