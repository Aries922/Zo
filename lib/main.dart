import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scoped_model/main.dart';
import 'pages/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zo',
        theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.purple,
          accentColor: Colors.red,
          fontFamily: 'RobotoSlab'

        ),
        home: Auth(),
      )
    );
  }
}

