import 'package:flutter/material.dart';
import 'package:hommy_app/pg_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'intro.dart';
import 'Animations/fade_animation.dart';
import 'package:page_transition/page_transition.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  Future cekFirstTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool seen = (pref.getBool('seen') ?? false);
    if (seen) {
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.upToDown, duration: Duration(seconds: 1), child: LoginPage()));
    }else{
      await pref.setBool('seen', true);
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: SliderIntro()));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),
    () {
      // Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_){ return new SliderIntro();}));
      cekFirstTime();
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