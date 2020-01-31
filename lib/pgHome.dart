import 'package:flutter/material.dart';
import 'package:hommy_app/auth/autentication.dart';
import 'package:hommy_app/pg_order.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSide extends StatefulWidget {
  @override
  _HomeSideState createState() => _HomeSideState();
}

class _HomeSideState extends State<HomeSide> {

  Map data;
  List userData;
  int count = 0;
  String nama = "";
  String token = "";
  
  
  getDataUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    
    setState(() {
      nama = pref.getString("nama");
      token = pref.getString("auth");
    });
  }

  Future getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('auth');
    http.Response response = await http.get(url+'api/service',  headers: { 'Authorization': 'Bearer $token', },);
    // print(response.body);
    data = jsonDecode(response.body);
    setState(() {
      userData = data["data"];
      
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getDataUser();
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      Text('Waiting...')
    ];
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backdash.png'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Wellcome, ', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(nama, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('How do you fill in this time?', style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            SizedBox(height: 40,),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Layanan Hommy', style: TextStyle(fontSize: 18),),
                            SizedBox(height: 10,),
                            Text('Beberapa Layanan di Hommy.ID', style: TextStyle(color: Colors.pinkAccent),),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 60),
                        child: 
                            Container(
                              child: GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 1.0,
                                padding: const EdgeInsets.all(10),
                                mainAxisSpacing: 15.0,
                                crossAxisSpacing: 12.0,
                                
                                children: userData == null ? list : new List.generate(userData.length, (index){
                                    return GestureDetector(
                                      onTap: () {
                                        
                                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: OrderPage(layanan: "${userData[index]['name']}",)));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(235, 26, 162, .3),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0, 2)
                                            )
                                          ]
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.access_alarm, size: 30.0),
                                            Text("${userData[index]['name']}", style:TextStyle(color: Colors.pinkAccent, fontSize: 14), textAlign: TextAlign.center,)
                                          ],
                                        ),
                                      ),
                                  );
                                  }
                                )
                              ),
                            )
                    
                      )
                      
                    ],
                  )
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}