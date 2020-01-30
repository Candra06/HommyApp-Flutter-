import 'package:flutter/material.dart';

class GridMenu extends StatefulWidget {
  @override
  _GridMenuState createState() => _GridMenuState();
}

class _GridMenuState extends State<GridMenu> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 12.0,
        children: <Widget>[
          Container(
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
                  Text('Lorem Ipsum Dolor', style:TextStyle(color: Colors.pinkAccent, fontSize: 14), textAlign: TextAlign.center,)
                ],
              ),
            ),
            Container(
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
                  Text('Lorem Ipsum Dolor', style:TextStyle(color: Colors.pinkAccent, fontSize: 14), textAlign: TextAlign.center,)
                ],
              ),
            ),
            Container(
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
                  Text('Lorem Ipsum Dolor', style:TextStyle(color: Colors.pinkAccent, fontSize: 14), textAlign: TextAlign.center,)
                ],
              ),
            ),
            Container(
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
                  Text('Lorem Ipsum Dolor', style:TextStyle(color: Colors.pinkAccent, fontSize: 14), textAlign: TextAlign.center,)
                ],
              ),
            ),
            Container(
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
                  Text('Lorem Ipsum Dolor', style:TextStyle(color: Colors.pinkAccent, fontSize: 14), textAlign: TextAlign.center,)
                ],
              ),
            ),
          
        ],
      ),
    );
  }
}