import 'package:flutter/material.dart';
import 'package:hommy_app/pg_detail.dart';
import 'package:page_transition/page_transition.dart';

class HistorySide extends StatefulWidget {
  @override
  _HistorySideState createState() => _HistorySideState();
}

class _HistorySideState extends State<HistorySide> {

List<String> layanan = [
  "Perbaikan",
  "Pembangunan",
  "Konsultasi RAB",
  "Design Bangunan"
];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: DetailPesanan()));
            });
          },
          child: ListView.builder(
            itemCount: layanan.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
                color: Color.fromRGBO(245, 244, 242, 1),
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.green,
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
                                Text('27', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                Text('Mei', style: TextStyle(fontSize: 13))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
                            child: Text(layanan[index]),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
        )
      ),
    );
  }
}