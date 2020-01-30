import 'package:flutter/material.dart';
// import 'package:hommy_app/intro.dart';
// import 'package:hommy_app/pg_login.dart';

import 'intro.dart';
import 'Animations/fade_animation.dart';
import 'package:page_transition/page_transition.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen())
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4),
    () {
      // Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 1500), child: SliderIntro()));
      // Navigator.of(context).pushReplacement(new PageTransition(type: PageTransitionType.rightToLeft, child: LoginPage()));
      Navigator.of(context).pushReplacement(new PageTransition(type: PageTransitionType.rightToLeft, child: SliderIntro()));
    }
    );

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/BackSplash.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(1, 
                          Text("WELCOME", style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54),),
                        ),
                        FadeAnimation(1.3, 
                          Text("TO", style: TextStyle(
                            fontSize: 40, 
                            fontWeight: FontWeight.w800, 
                            color: Colors.black54)),
                        ),
                        FadeAnimation(1.6, 
                          Text("HOMMY.ID", style: TextStyle(
                            fontSize: 40, 
                            fontWeight: FontWeight.w800, 
                            color: Colors.pinkAccent)),
                        )
                      ],
                    )
                  ),
                ],
              ),
        ),
      ),
    );
  }
}