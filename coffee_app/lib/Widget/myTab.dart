import 'package:flutter/material.dart';

class myTab extends StatelessWidget {
  String ?imgPath;
  myTab({super.key , required this.imgPath});
  @override
  Widget build(BuildContext context) {
    return Tab(
     height: 90,
      child: Container(
        padding: EdgeInsets.all(8),
        height: 55,
        width: 70,
        child: Image.asset(imgPath!),
      decoration: BoxDecoration(color: Colors.purple[50] , borderRadius: BorderRadius.circular(10))),
    );
  }
}