import 'package:firebase/home/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(Main());

class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Firebase in Flutter",
      home: HomeLayout(),
    );
  }
}