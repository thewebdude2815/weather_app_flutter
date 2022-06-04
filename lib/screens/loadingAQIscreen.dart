// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app_project/inc/networking.dart';
import 'package:weather_app_project/inc/currentposition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app_project/screens/aqiDetails.dart';
import 'package:weather_app_project/screens/currentweather.dart';

class LoadingAQIScreen extends StatefulWidget {
  String? cityName;
  LoadingAQIScreen({this.cityName});

  @override
  _LoadingAQIScreenState createState() => _LoadingAQIScreenState();
}

class _LoadingAQIScreenState extends State<LoadingAQIScreen> {
  double? longitude;
  double? latitude;

  @override
  void initState() {
    super.initState();
    getAQIOfCurrentLocation();
  }

  Future getAQIOfCurrentLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper networkHelperAQI = NetworkHelper(
        urlLink:
            'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=e4dd0eca47af3636adf36caca5f02545&units=metric');
    var aqiData = await networkHelperAQI.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AQIDetails(
        AqiInfo: aqiData,
        cityName: widget.cityName,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitSpinningLines(
        color: Colors.amberAccent,
        size: 90.0,
      ),
    ));
  }
}
