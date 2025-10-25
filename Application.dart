import 'package:assignment_mod_16/CRUD_Project/App_Structure.dart';
//import 'package:assignment_mod_16/main.dart';
import 'package:flutter/material.dart';

class myapp extends StatelessWidget{
  myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: 'My App',
      home: App_Structure(),
    );
  }
}
