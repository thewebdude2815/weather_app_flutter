// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app_project/inc/networking.dart';
import 'package:weather_app_project/screens/searchWeather.dart';

class SearchedCity extends StatefulWidget {
  String? cityName;
  SearchedCity({required this.cityName});

  @override
  _SearchedCityState createState() => _SearchedCityState();
}

class _SearchedCityState extends State<SearchedCity> {
  void initState() {
    super.initState();
    getCityWeather(widget.cityName);
  }

  void getCityWeather(String? cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        urlLink:
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=e4dd0eca47af3636adf36caca5f02545&units=metric');

    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchedCityWeather(
        searchedCityData: weatherData,
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
