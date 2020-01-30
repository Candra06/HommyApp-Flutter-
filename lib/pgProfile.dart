import 'package:flutter/material.dart';

class ProfileSide extends StatefulWidget {
  @override
  _ProfileSideState createState() => _ProfileSideState();
}

class _ProfileSideState extends State<ProfileSide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backdash1.png'),
                  fit: BoxFit.cover
                )
              ),
            ),
          )
        ],
      )
    );
  }
}