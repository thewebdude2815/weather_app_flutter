// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app_project/inc/networking.dart';
import 'package:weather_app_project/inc/currentposition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app_project/screens/currentweather.dart';

import 'hourlyweather.dart';

class LoadingHourlyScreen extends StatefulWidget {
  String? cityName;
  LoadingHourlyScreen({this.cityName});

  @override
  _LoadingHourlyScreenState createState() => _LoadingHourlyScreenState();
}

class _LoadingHourlyScreenState extends State<LoadingHourlyScreen> {
  double? longitude;
  double? latitude;

  @override
  void initState() {
    super.initState();
    getHourlyLocation();
  }

  Future getHourlyLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper networkHelperHourly = NetworkHelper(
        urlLink:
            'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=current,minutely&appid=e4dd0eca47af3636adf36caca5f02545&units=metric');
    var weatherData = await networkHelperHourly.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HorulyWeather(weatherData: weatherData, city: widget.cityName);
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
