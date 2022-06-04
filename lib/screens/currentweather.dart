// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_new, annotate_overrides, unused_local_variable, avoid_print, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather_app_project/inc/drawer.dart';
import 'package:weather_app_project/inc/getWeatherIcon.dart';
import 'package:weather_app_project/inc/tempExplained.dart';
import 'package:weather_app_project/screens/loadingAQIscreen.dart';
import 'package:weather_app_project/screens/loadingDailyScreen.dart';
import 'package:weather_app_project/screens/loadingHourlyScreen.dart';
import 'package:weather_app_project/screens/searchCity.dart';
import '../inc/currentDate.dart';
import 'package:flutter_svg/flutter_svg.dart';  

class CurrentWeather extends StatefulWidget {
  final currentLocationWeather;

  // final hourlyData;
  CurrentWeather({this.currentLocationWeather});

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
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

  List<Widget> todayWeather = [];

  @override
  void initState() {
    super.initState();
    updateUI(widget.currentLocationWeather);
  }

  void updateAQI(dynamic aqiData) {
    String aqiInString;
    setState(() {
      aqi = aqiData['list'][0]['main']['aqi'];
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

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      cityName = "Error";
      description = "whoops!";
      imgIcon = 'whoops';
      return;
    }
    // cityName
    cityName = weatherData['name'];
    // weather description
    description = weatherData['weather'][0]['description'];
    // weather id
    id = weatherData['weather'][0]['id'];
    // temperature
    double temperatures = weatherData['main']['temp'];
    temperature = temperatures.toInt();
    // weather icon
    imgIcon = weatherData['weather'][0]['icon'];
    // feels like
    double feels_like_data = weatherData['main']['feels_like'];
    feels_like = feels_like_data.toInt();
    // max temp
    double max_temp_data = weatherData['main']['temp_max'];
    max_temp = max_temp_data.toInt();
    // min temp
    double min_temp_data = weatherData['main']['temp_min'];
    min_temp = min_temp_data.toInt();
    // humidity
    humidity = weatherData['main']['humidity'];
    // windSpeed
    dynamic wind_data = weatherData['wind']['speed'];
    wind = wind_data.toInt();
    // cloud Cover
    int pressure_data = weatherData['clouds']['all'];
    pressure = pressure_data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyHeaderDrawer(),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Home',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SearchCity();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Search For A City',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoadingHourlyScreen(cityName: cityName);
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Daily Current Weather',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoadingDailyScreen(cityName: cityName);
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '5 Days Weather',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () async {
                var typedName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchCity();
                    },
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/search.svg',
                height: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // title: Text('Weather App'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container For City Name, Date And AQI starts

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${cityName}',
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
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoadingAQIScreen(
                              cityName: cityName,
                            );
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/leaf.svg',
                                  height: 20.0, color: Colors.white),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("AQI",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Container For City Name, Date And AQI ends
                SizedBox(
                  height: 30.0,
                ),
                // Container For Weather Description, Centi and Icon starts
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0),
                    ),
                    gradient: LinearGradient(
                        colors: [Color(0xFFFA62E4), Color(0xFF3463f2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  child: Stack(
                      overflow: Overflow.visible,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            '${description!.toUpperCase()}',
                            style: TextStyle(
                                letterSpacing: 4, color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: GradientText(
                            '${temperature}°',
                            colors: [
                              Colors.white,
                              Colors.white60,
                            ],
                            style: TextStyle(fontSize: 125.0),
                          ),
                        ),
                        Positioned(
                          bottom: -80,
                          child: Container(
                              child: SvgPicture.asset(
                            getWeatherIcon(id),
                            height: 160,
                          )),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Container(
                  height: 160,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    ],
                  ),
                ),

                // ROW FRO HOURLY AND 5 DAY WEATRHER

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoadingHourlyScreen(
                                  cityName: cityName,
                                );
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
                              bottomRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),
                            ),
                            gradient: LinearGradient(
                                colors: [Color(0xFFFA62E4), Color(0xFF3463f2)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Hourly Weather',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoadingDailyScreen(
                                  cityName: cityName,
                                );
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
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                            ),
                            gradient: LinearGradient(
                                colors: [Color(0xFFFA62E4), Color(0xFF3463f2)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '5 Days',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Image.network(
//   'http://openweathermap.org/img/w/${imgIcon}.png',
//   height: 140,
// )
// Text(
//                               '${getWeatherIcon(id)}',
//                               style: TextStyle(fontSize: 140),
//                             ),
