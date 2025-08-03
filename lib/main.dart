import 'package:flutter/material.dart';
import 'Home.dart';

void main(){
  runApp(Runner());
}

class Runner extends StatelessWidget {

  const Runner({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
