// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, dead_code, non_constant_identifier_names, unnecessary_new

import 'dart:ui';

import 'package:flutter/material.dart ';

import 'package:intl/intl.dart';
import 'package:weather_app_project/inc/backButton.dart';

import 'package:weather_app_project/inc/getWeatherIcon.dart';
import 'package:weather_app_project/main.dart';
import 'package:weather_app_project/screens/hourlyweather.dart';

class DailyWeather extends StatefulWidget {
  DailyWeather({required this.city, required this.weatherData});
  dynamic city;
  dynamic weatherData;

  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  dynamic weatherDate;

  dynamic date;
  @override
  void initState() {
    super.initState();
    updateDaily(widget.weatherData);
  }

  dynamic temp_daily;
  List<Widget> dailyWeather = [];

  void updateDaily(dynamic weatherData) {
    temp_daily = weatherData;
    var date = new DateTime.now();
    var dateParse = DateTime(date.year, date.month, date.day);
    for (var i = 0; i < 5; i++) {
      String day = DateFormat("EEEE")
          .format(DateTime(date.year, date.month, date.day + i + 1))
          .substring(0, 3);
      var dailyData = hourlyDailyDataContainer(
        time: day,
        icon: getWeatherDailyIcon(temp_daily['daily'][i]["weather"][0]["id"]),
        details: temp_daily['daily'][i]['weather'][0]['main'],
        wind: temp_daily['daily'][i]['wind_speed'],
        feels_like: temp_daily['daily'][i]['feels_like']['day'],
        humidity: temp_daily['daily'][i]['humidity'],
        temp: temp_daily['daily'][i]["temp"]['day'],
      );
      dailyWeather.add(dailyData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/cloudy.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.9), BlendMode.softLight),
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 17.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeButton(
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WeatherApp();
                        }));
                      },
                      textButton: 'Home Page',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Daily Weather',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 27.0, color: Colors.white),
                    ),
                    Text(
                      '${widget.city}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25.0, color: Colors.white54),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: dailyWeather,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
