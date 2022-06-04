// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart ';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_project/inc/backButton.dart';
import 'package:weather_app_project/inc/dailyweathersection.dart';
import 'package:weather_app_project/inc/getWeatherIcon.dart';
import 'package:weather_app_project/main.dart';

class HorulyWeather extends StatefulWidget {
  dynamic weatherData;
  dynamic city;

  HorulyWeather({required this.weatherData, required this.city});

  @override
  State<HorulyWeather> createState() => _HorulyWeatherState();
}

class _HorulyWeatherState extends State<HorulyWeather> {
  @override
  void initState() {
    super.initState();
    // updateAQI(widget.currentAQI);
    updateHoury(widget.weatherData);
  }

  dynamic temp_hourly;
  List<Widget> todayWeather = [];

  void updateHoury(dynamic weatherData) {
    temp_hourly = weatherData;
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    int hour = int.parse(DateFormat("hh").format(dateParse));
    for (var i = 0; i < 8; i++) {
      var todayData = hourlyDailyDataContainer(
        time: Duration(hours: hour + i + 1).toString().split(":")[0] + ":00",
        icon: getWeatherDailyIcon(temp_hourly['hourly'][i]["weather"][0]["id"]),
        details: temp_hourly['hourly'][i]['weather'][0]['main'],
        wind: temp_hourly['hourly'][i]['wind_speed'],
        feels_like: temp_hourly['hourly'][i]['feels_like'],
        humidity: temp_hourly['hourly'][i]['humidity'],
        temp: temp_hourly['hourly'][i]["temp"],
      );
      todayWeather.add(todayData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/sunny.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.9), BlendMode.softLight),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeButton(
                    textButton: "Home Page",
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WeatherApp();
                      }));
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Hourly Weather',
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
                      children: todayWeather,
                    ),
                  ),
                  // Container(
                  //   height: 130,
                  //   width: double.infinity,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: todayWeather,
                  //   ),
                  // ),

                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class hourlyDailyDataContainer extends StatelessWidget {
  dynamic details;
  dynamic temp;
  dynamic feels_like;
  dynamic humidity;
  dynamic wind;
  dynamic? icon;
  dynamic? time;

  hourlyDailyDataContainer(
      {required this.details,
      required this.temp,
      required this.feels_like,
      required this.humidity,
      required this.wind,
      required this.icon,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      height: MediaQuery.of(context).size.height * 0.5,
      width: 100,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFFA62E4), Color(0xFF3463f2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            time,
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
          Text(
            details,
            style: TextStyle(color: Colors.white, fontSize: 17.0),
          ),
          Text(
            '$icon',
            style: TextStyle(fontSize: 25),
          ),
          Text(
            '${temp.toStringAsFixed(0)} °C',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          Container(
            child: Column(children: [
              SvgPicture.asset(
                'assets/feels_like.svg',
                height: 20,
              ),
              Text(
                '${feels_like.toStringAsFixed(0)} °C',
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              )
            ]),
          ),
          Container(
            child: Column(children: [
              SvgPicture.asset(
                'assets/humidity.svg',
                height: 20,
              ),
              Text(
                '${humidity}',
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              )
            ]),
          ),
          Container(
            child: Column(children: [
              SvgPicture.asset(
                'assets/wind.svg',
                height: 20,
              ),
              Text(
                '${wind}',
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
