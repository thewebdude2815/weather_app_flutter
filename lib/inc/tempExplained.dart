// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TempExplaination extends StatelessWidget {
  final String heading;
  final int temp;
  final String svgIcon;
  final String icon;
  TempExplaination(
      {required this.heading,
      required this.svgIcon,
      required this.temp,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 7.0),
          child: SvgPicture.asset(
            '$svgIcon',
            color: Colors.white,
            height: 25,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$heading",
                style: TextStyle(color: Colors.white, fontSize: 11.0)),
            Text("${temp} ${icon}",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ],
    );
  }
}
