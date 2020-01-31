import 'package:flutter/material.dart';
import 'package:hommy_app/pg_login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSide extends StatefulWidget {
  @override
  _ProfileSideState createState() => _ProfileSideState();
}

class _ProfileSideState extends State<ProfileSide> {

  Future logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setBool("isLogin", false);
    pref.setString("nama", null);
    pref.setString("auth", null);
    pref.setString("email", null);
    pref.setString("id", null);
    Navigator.of(context).pushReplacement(new PageTransition(type: PageTransitionType.fade, duration: Duration(seconds: 1), child: LoginPage()));
    });
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
                  fit: BoxFit.cover
                )
              ),
              child: Expanded(
                child: Container(
                  
                ),
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
                    child: Text('Member', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.black54),),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Icon(Icons.email, color: Colors.black45,),
                    ),
                    Text('Email Address', style: TextStyle(color: Colors.black87),)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Icon(Icons.phone, color: Colors.black45,),
                    ),
                    Text('Nomor HP', style: TextStyle(color: Colors.black87))
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    logOut();
                  },child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Icon(Icons.exit_to_app, color: Colors.black45,),
                    ),
                    Text('Logout', style: TextStyle(color: Colors.black87))
                  ],
                ),
                )
              ],
            ),
            ),
          ),
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width * 1/3,
            right: MediaQuery.of(context).size.width * 1/3,
            child: Container(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundImage:  AssetImage('assets/images/feby.png'),
                backgroundColor: Colors.transparent,
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
      )
    );
  }
}