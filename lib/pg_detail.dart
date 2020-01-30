import 'package:flutter/material.dart';

class DetailPesanan extends StatefulWidget {
  @override
  _DetailPesananState createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {

  int indexStep = 0;

  List<Step>lstStep=<Step>[
    Step(
      title: Text("1 Januari 2019"),
      subtitle: Text('Pengajuan dikirim'),
      content: Text('Anda memesan layanan'),
      isActive: true
    ),
    Step(
      title: Text("1 Januari 2019"),
      subtitle: Text('Pengajuan dikirim'),
      content: Text('Anda memesan layanan'),
      isActive: true
    ),
    Step(
      title: Text("1 Januari 2019"),
      subtitle: Text('Pengajuan dikirim'),
      content: Text('Anda memesan layanan'),
      isActive: true
    ),
    Step(
      title: Text("1 Januari 2019"),
      subtitle: Text('Pengajuan dikirim'),
      content: Text('Anda memesan layanan'),
      isActive: true
    ),
    Step(
      title: Text("1 Januari 2019"),
      subtitle: Text('Pengajuan dikirim'),
      content: Text('Anda memesan layanan'),
      isActive: true
    ),
    Step(
      title: Text("1 Januari 2019"),
      subtitle: Text('Pengajuan dikirim'),
      content: Text('Anda memesan layanan'),
      isActive: true
    ),
    Step(
      title: Text("1 Januari 2019"),
      subtitle: Text('Pengajuan dikirim'),
      content: Text('Anda memesan layanan'),
      isActive: true
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        backgroundColor: Colors.pinkAccent,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
                          child: Text('Nama ' ),
                        ),
                        Container(
                          constraints: BoxConstraints(minWidth: 5, maxWidth: 10),
                          child: Text(' : '),
                        ),
                        Container(
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                          child: Text('Abiyu Candra Adiansyah'),
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
                          child: Text('Jenis layanan' ),
                        ),Container(
                          constraints: BoxConstraints(minWidth: 5, maxWidth: 10),
                          child: Text(' : '),
                        ),
                        Container(
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                          child: Text('Perbaikan', style: TextStyle(color: Colors.pinkAccent),),
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
                          child: Text('Alamat' ),
                        ),Container(
                          constraints: BoxConstraints(minWidth: 5, maxWidth: 10),
                          child: Text(' : '),
                        ),
                        Container(
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
                          child: Text('Jl. Mastrip No.21 RT.23 RW.08 Kembang Bondowoso'),
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
                          child: Text('Status' ),
                        ),Container(
                          constraints: BoxConstraints(minWidth: 5, maxWidth: 10),
                          child: Text(' : '),
                        ),
                        Container(
                          constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                          child: Text('Selesai', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text('Progress Layanan ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                  Container(
                    child: SingleChildScrollView(

                      child: Column(
                        children: <Widget>[
                          
                          Stepper(
                            steps: lstStep,
                            physics: ClampingScrollPhysics(),
                            currentStep: indexStep,
                            type: StepperType.vertical,
                            onStepCancel: () {
                              setState(() {
                                indexStep=0;
                              });
                            },
                            onStepContinue: () {
                              setState(() {
                                indexStep++;
                              });
                            },
                            onStepTapped: (step) {
                              setState(() {
                                indexStep = step;
                              });
                            },
                            controlsBuilder: (BuildContext context,
                                          {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
                                      Container(),
                          ),
                        ],
                      )
                    )
                  )

                ],
              ),
            ),
            
          ],
        ),
      )
      
    );
  }
}