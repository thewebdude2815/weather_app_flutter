// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app_project/inc/backButton.dart';
import 'package:weather_app_project/inc/cityData.dart';
import 'package:weather_app_project/inc/currentDate.dart';
import 'package:weather_app_project/inc/getMessage.dart';
import 'package:weather_app_project/inc/tempExplained.dart';
import 'package:weather_app_project/inc/getWeatherIcon.dart';
import 'package:weather_app_project/main.dart';
import 'package:weather_app_project/screens/loading_screen.dart';
import 'package:weather_app_project/screens/searchCity.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SearchedCityWeather extends StatefulWidget {
  dynamic searchedCityData;
  SearchedCityWeather({required this.searchedCityData});

  @override
  State<SearchedCityWeather> createState() => _SearchedCityWeatherState();
}

class _SearchedCityWeatherState extends State<SearchedCityWeather> {
  String? cityName;
  String? description;
  int temperature = 0;
  String? imgIcon;
  int aqi = 0;
  int id = 0;
  dynamic temp_hourly;
  int max_temp = 0;
  int min_temp = 0;
  int feels_like = 0;
  int humidity = 0;
  int wind = 0;
  int pressure = 0;
  String? error;
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  void initState() {
    super.initState();
    updateUI(widget.searchedCityData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        cityName = "Error";
        description = "whoops!";
        imgIcon = 'whoops';
        return;
      }

      print(weatherData['cod']);
      cityName = weatherData['name'];
      description = weatherData['weather'][0]['description'];
      id = weatherData['weather'][0]['id'];
      double temperatures = weatherData['main']['temp'];
      temperature = temperatures.toInt();
      imgIcon = weatherData['weather'][0]['icon'];
      double feels_like_data = weatherData['main']['feels_like'];
      feels_like = feels_like_data.toInt();
      double max_temp_data = weatherData['main']['temp_max'];
      max_temp = max_temp_data.toInt();
      double min_temp_data = weatherData['main']['temp_min'];
      min_temp = min_temp_data.toInt();
      humidity = weatherData['main']['humidity'];
      dynamic wind_data = weatherData['wind']['speed'];
      wind = wind_data.toInt();
      int pressure_data = weatherData['clouds']['all'];
      pressure = pressure_data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: HomeButton(
                textButton: "Search Page",
                ontap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchCity();
                  }));
                },
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cityName!.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        letterSpacing: 4,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                        ),
                        gradient: LinearGradient(
                            colors: [Color(0xFFFA62E4), Color(0xFF3463f2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: Center(
                        child: Text(
                          '${getCurrentDate()}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                            colors: [Color(0xFF303030), Color(0xFF434343)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  child: SvgPicture.asset(
                                getWeatherIcon(id),
                                height: 140,
                              )),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${description!.toUpperCase()}',
                                    style: TextStyle(
                                        letterSpacing: 4, color: Colors.white),
                                  ),
                                  GradientText(
                                    '${temperature}°',
                                    colors: [
                                      Colors.white,
                                      Colors.white54,
                                      Colors.white,
                                    ],
                                    style: TextStyle(fontSize: 95.0),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TempExplaination(
                                      icon: "°",
                                      temp: feels_like,
                                      svgIcon: "assets/feels_like.svg",
                                      heading: "Feels Like",
                                    ),
                                    TempExplaination(
                                      icon: "°",
                                      temp: max_temp,
                                      svgIcon: "assets/max_temp.svg",
                                      heading: "Max Temp",
                                    ),
                                    TempExplaination(
                                      icon: "°",
                                      temp: min_temp,
                                      svgIcon: "assets/min_temp.svg",
                                      heading: "Min Temp",
                                    )
                                  ],
                                ),
                                SizedBox(height: 40.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TempExplaination(
                                      icon: "%",
                                      temp: humidity,
                                      svgIcon: "assets/humidity.svg",
                                      heading: "Humidity",
                                    ),
                                    TempExplaination(
                                      icon: "km/h",
                                      temp: wind,
                                      svgIcon: "assets/wind.svg",
                                      heading: "Wind",
                                    ),
                                    TempExplaination(
                                      icon: "%",
                                      temp: pressure,
                                      svgIcon: "assets/clouds.svg",
                                      heading: "Cloud Cover",
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  getMessage(temperature),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WeatherApp();
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0),
                          ),
                          gradient: LinearGradient(
                              colors: [Color(0xFFFA62E4), Color(0xFF3463f2)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Back Home',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
