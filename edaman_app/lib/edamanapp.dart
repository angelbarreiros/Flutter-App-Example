import 'package:edaman_app/Pantallas/Horizontal/tablet.dart' as horizontal;
import 'package:edaman_app/Pantallas/Vertical/formlist.dart' as vertical;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const int breakPoint = 600;

class MyApp extends StatelessWidget {
  String title;

  MyApp({required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
        primaryColor: Colors.pink,
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Orientacion(title: title),
    );
  }
}

class Orientacion extends StatelessWidget {
  final String title;

  Orientacion({required this.title});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool chooseMasterAndDetail =
          (constraints.smallest.longestSide > breakPoint &&
              MediaQuery.of(context).orientation == Orientation.landscape);
      return chooseMasterAndDetail
          ? horizontal.Horizontal(title: title)
          : vertical.Vertical(title: title);
    });
  }
}
