import 'package:flutter/material.dart';
import 'home/home_page.dart';

void main() => runApp(WeChatApp());

class WeChatApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '微信',
      home: HomePage(),
    );
  }

}

