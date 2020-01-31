import 'package:flutter/material.dart';
import 'intro.dart';
import 'Animations/fade_animation.dart';
import 'package:page_transition/page_transition.dart';
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
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_){ return new SliderIntro();}));
    }
    );

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FadeAnimation(1, 
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Image(
                            image: AssetImage('assets/images/logo-new.png'),
                            ),
                          )
                        ),
                        
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