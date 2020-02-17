import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'auth/autentication.dart';

class DetailPesanan extends StatefulWidget {
  final String idDetail;

  DetailPesanan({Key key, this.idDetail}) : super(key: key);
  @override
  _DetailPesananState createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  String token = "";
  String nama = "";
  String layanan = "";
  String alamat = "";
  String status = "";
  String id;
  List progres;
  Map data;
  int len = 0;
  List<dynamic> listTimeline;

  int indexStep = 0;

  Future getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('auth');
      nama = pref.getString('nama');
      id = pref.getString('id');
      // print(token);
    });
  }

  Future getDetail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('auth');
    http.Response res = await http.post(url + 'api/order/detail', body: {
      'id_order': "${widget.idDetail}",
    }, headers: {
      'Authorization': 'Bearer $token',
    });
    // print(res.body);
    data = jsonDecode(res.body);
    setState(() {
      listTimeline = data["data"];
      // print(listTimeline);
      len = listTimeline.length;
      alamat = data["data"][0]['address'];
      layanan = data["data"][0]['service'];
      status = data["data"][0]['status'];
      if (int.parse(status) == 1) {
        status = "Waiting";
      }else if (int.parse(status) == 2) {
        status = "Survei";
      }else if (int.parse(status) == 3) {
        status = "Proses";
      }else if (int.parse(status) == 4) {
        status = "Selesai";
      }
      progres = data["data"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getDetail();
    // print(listData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        backgroundColor: Colors.pinkAccent,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
                      child: Text('Nama '),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 5, maxWidth: 10),
                      child: Text(' : '),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: Text(nama),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
                      child: Text('Jenis layanan'),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 5, maxWidth: 10),
                      child: Text(' : '),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: Text(
                        layanan,
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
                      child: Text('Alamat'),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 5, maxWidth: 10),
                      child: Text(' : '),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
                      child: Text(alamat),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
                      child: Text('Status'),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 5, maxWidth: 10),
                      child: Text(' : '),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: Text(
                        status,
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  'Progress Layanan ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                // child: Text('data'),
                child: listTimeline == null
                    ? Text('Loading..')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: listTimeline.length,
                        physics: new ScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) {
                          return Column(
                              children: <Widget>[
                                Container(
                                    child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 5.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              width: 25,
                                              height: 25,
                                              padding: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  border: Border.all(
                                                      width: 10.0,
                                                      color: Colors.pink))),
                                          GestureDetector(
                                            onTap: () {
                                              _showModalSheet("${listTimeline[i]['image']}");

                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.0, top: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      '${listTimeline[i]['date']}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.pinkAccent),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      '${listTimeline[i]['title']}',
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 22.0),
                                      child: Row(children: <Widget>[
                                        Container(
                                          height: 40,
                                          width: 2.0,
                                          color: Colors.pink,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                        )
                                      ]),
                                    ),
                                  ],
                                ))
                              ],
                            
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showModalSheet(String src) {
    showModalBottomSheet(context: context, builder: (builder) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Foto Progress', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 18),),
          Container(
            padding: EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url+src),
                
              )
            ),
            
          ),
        ],
      );
    });
  }
}
