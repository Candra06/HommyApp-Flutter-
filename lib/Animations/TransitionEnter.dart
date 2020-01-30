import 'package:flutter/material.dart';

class EnterExit extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  EnterExit({this.exitPage, this.enterPage}): super(
    pageBuilder: (
      BuildContext context, 
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
      Stack(
        children: <Widget>[
          SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: const Offset(-1.0, 0.0)
            ).animate(animation),
            child: exitPage,
          ),
          SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero
            ).animate(animation),
            child: enterPage,
        ), 
        ],
      )
  );
}