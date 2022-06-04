// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class DailyWeatherSection extends StatelessWidget {
  dynamic hourlyTemp;
  String? icon;
  dynamic? time;
  DailyWeatherSection(
      {required this.hourlyTemp, required this.icon, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      height: 130.0,
      width: 80.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFFA62E4),
            Color(0xFF3463f2),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(45)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '$time',
            style: TextStyle(color: Colors.white60, fontSize: 13.0),
          ),
          Text(
            '$icon',
            style: TextStyle(fontSize: 25),
          ),
          // Image.network('http://openweathermap.org/img/w/${icon}.png'),
          Text(
            '${hourlyTemp.toInt()}°',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          )
        ],
      ),
    );
  }
}
