import 'package:ff/Widget/Custom_App_Bar.dart';
import 'package:ff/Widget/Screen.dart';
import 'package:flutter/material.dart';

class Mypage extends StatefulWidget {
  Mypage({Key? key}) : super(key: key);

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const myappbar(), body: Containe());
  }
}
