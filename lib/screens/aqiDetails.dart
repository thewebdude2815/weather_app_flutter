// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:weather_app_project/inc/backButton.dart';
import 'package:weather_app_project/inc/currentDate.dart';
import 'package:weather_app_project/screens/loading_screen.dart';

class AQIDetails extends StatefulWidget {
  String? cityName;
  dynamic AqiInfo;
  AQIDetails({required this.cityName, required this.AqiInfo});

  @override
  _AQIDetailsState createState() => _AQIDetailsState();
}

class _AQIDetailsState extends State<AQIDetails> {
  int aqi = 0;
  dynamic pm;
  dynamic pm10;
  dynamic s02;
  dynamic no2;
  dynamic co;
  dynamic o3;
  @override
  void initState() {
    super.initState();
    updateAQI(widget.AqiInfo);
  }

  void updateAQI(dynamic aqiData) {
    setState(() {
      aqi = aqiData['list'][0]['main']['aqi'];
      pm = aqiData['list'][0]['components']['pm2_5'];
      pm10 = aqiData['list'][0]['components']['pm10'];
      s02 = aqiData['list'][0]['components']['so2'];
      no2 = aqiData['list'][0]['components']['no2'];
      co = aqiData['list'][0]['components']['co'];
      o3 = aqiData['list'][0]['components']['o3'];
    });
  }

  String conditionAQI(aqiValue) {
    String aqiName = 'Good';
    if (aqiValue == 1) {
      aqiName = 'Good';
    } else if (aqiValue == 2) {
      aqiName = 'Fair';
    } else if (aqiValue == 3) {
      aqiName = 'Moderate';
    } else if (aqiValue == 4) {
      aqiName = 'Poor';
    } else if (aqiValue == 5) {
      aqiName = 'Very Poor';
    }
    return aqiName;
  }

  String conditionAQIDesc(aqiValue) {
    String aqiDesc = '';
    if (aqiValue == 1) {
      aqiDesc =
          'Air quality is satisfactory, and air pollution poses little or no risk.';
    } else if (aqiValue == 2) {
      aqiDesc =
          'Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution.';
    } else if (aqiValue == 3) {
      aqiDesc =
          'Members of sensitive groups may experience health effects. The general public is less likely to be affected.';
    } else if (aqiValue == 4) {
      aqiDesc =
          'Health alert: The risk of health effects is increased for everyone.';
    } else if (aqiValue == 5) {
      aqiDesc =
          'Health warning of emergency conditions: everyone is more likely to be affected.';
    }
    return aqiDesc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeButton(
                    ontap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LoadingScreen();
                      }));
                    },
                    textButton: "Back Home"),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cityName!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${getCurrentDate()}',
                        style: TextStyle(color: Colors.white38, fontSize: 15.0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: 262,
                    height: 260,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFFFA62E4),
                              Color(0xFF3463f2),
                              Color(0xFF303030),
                              Color(0xFF303030)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF434343),
                              Color(0xFF303030),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(130),
                      ),
                      width: 240,
                      height: 240,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'AQI',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Text(
                            conditionAQI(aqi),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Air Quality Index: ${aqi}',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    conditionAQIDesc(aqi),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF303030), Color(0xFF434343)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  pm.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                                Text(
                                  'PM2.5',
                                  style: TextStyle(
                                      color: Colors.blue.withOpacity(0.7),
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  pm10.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                                Text(
                                  'PM10',
                                  style: TextStyle(
                                      color: Colors.blue.withOpacity(0.7),
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  s02.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                                Text(
                                  'SO2',
                                  style: TextStyle(
                                      color: Colors.blue.withOpacity(0.7),
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  no2.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                                Text(
                                  'NO2',
                                  style: TextStyle(
                                      color: Colors.blue.withOpacity(0.7),
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  co.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                                Text(
                                  'CO',
                                  style: TextStyle(
                                      color: Colors.blue.withOpacity(0.7),
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  o3.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                                Text(
                                  'O3',
                                  style: TextStyle(
                                      color: Colors.blue.withOpacity(0.7),
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
