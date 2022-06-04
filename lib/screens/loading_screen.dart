// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app_project/inc/cityData.dart';
import 'package:weather_app_project/inc/networking.dart';
import 'package:weather_app_project/inc/currentposition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app_project/screens/currentweather.dart';
import 'package:weather_app_project/screens/searchCity.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? longitude;
  double? latitude;
  String? cityName;

  void initState() {
    super.initState();
    getLocation();
  }

  Future getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper networkHelper = NetworkHelper(
        urlLink:
            'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=e4dd0eca47af3636adf36caca5f02545&units=metric');

    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CurrentWeather(currentLocationWeather: weatherData);
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
