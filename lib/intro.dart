import 'package:flutter/material.dart';
import 'package:hommy_app/pg_login.dart';
import 'package:hommy_app/utilities/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/intro_slider.dart';


class SliderIntro extends StatefulWidget {
  @override
  _SliderIntroState createState() => _SliderIntroState();
}

class _SliderIntroState extends State<SliderIntro> {

  List<Slide> slides = new List();

  Function goToTap;

  @override
  void initState() {
    super.initState(); 

    slides.add(
      new Slide(
        title: "Professional",
        styleTitle: kTitleStyle,
        description: "Kompetensi tukang tersertifikasi sesuai dengan bidangnya masing-masing.",
        marginDescription: EdgeInsets.all(20),
        styleDescription: kSubtitleStyle,
        pathImage: "assets/images/onboarding0.png",
      ),
    );
     slides.add(
      new Slide(
        title: "Terpercaya",
        styleTitle: kTitleStyle,
        description: "Tenaga tukang dengan kepribadian yang amanah serta penuh tanggung jawab.",
        styleDescription: kSubtitleStyle,
        pathImage: "assets/images/onboarding0.png",
      ),
    );
     slides.add(
      new Slide(
        title: "Proses Mudah",
        styleTitle: kTitleStyle,
        description: "Proses pemesanan jasa tukang bangunan sangat mudah untuk dilakukan.",
        styleDescription: kSubtitleStyle,
        pathImage: "assets/images/onboarding0.png",
      ),
    );
  }

  void onDonePress() {
    Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: LoginPage()));
  }

  void onTabChangeComplete(index){

  }

  Widget renderNextBtn(){
    return Text('Lanjut', style: TextStyle(color: Colors.white, fontSize: 15),);
  }

  Widget renderBtnDone(){
    return Text('Selesai', style: TextStyle(color: Colors.white, fontSize: 15),);
  }

  Widget renderSkipButton() {
    return Text('Lewati', style: TextStyle(color: Colors.white, fontSize: 15),);
  }

  List<Widget> renderListCustomTab() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                    currentSlide.pathImage,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  )
              ),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IntroSlider(
          // List slides
          slides: this.slides,

          // Skip button
          renderSkipBtn: this.renderSkipButton(),
          colorSkipBtn: Colors.pinkAccent,
          highlightColorSkipBtn: Colors.white,

          // Next button
          renderNextBtn: this.renderNextBtn(),

          // Done button
          renderDoneBtn: this.renderBtnDone(),
          onDonePress: this.onDonePress,
          colorDoneBtn: Colors.pinkAccent,
          highlightColorDoneBtn: Colors.white,

          // Dot indicator
          colorDot: Colors.black45,
          colorActiveDot: Colors.pinkAccent,
          sizeDot: 8.0,

          // Tabs
          listCustomTabs: this.renderListCustomTab(),
          backgroundColorAllSlides: Colors.white,
          refFuncGoToTab: (refFunc) {
            this.goToTap = refFunc;
          },

          // Show or hide status bar
          shouldHideStatusBar: false,

          // On tab change completed
          onTabChangeCompleted: this.onTabChangeComplete,
        ),
      ),
    );
  }
}