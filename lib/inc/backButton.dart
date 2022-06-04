// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:weather_app_project/main.dart';

class HomeButton extends StatelessWidget {
  final textButton;
  final ontap;
  HomeButton({required this.ontap, required this.textButton});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: 30.0,
              color: Colors.white,
            ),
            Text(
              textButton,
              style: TextStyle(color: Colors.white38, fontSize: 13.0),
            ),
          ],
        ),
      ),
    );
  }
}
