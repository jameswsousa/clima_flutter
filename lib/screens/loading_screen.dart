import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = '04d266782c572da0f6ceb9d89ba1ebb8';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    print(latitude);
    print(longitude);
    getData();
  }

  void getData() async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    if (response.statusCode == 200) {
      String data = response.body;

      var temp = jsonDecode(data)['main']['temp'];
      var conditionNum = jsonDecode(data)['weather'][0]['id'];
      var cityName = jsonDecode(data)['name'];
      print(temp);
      print(conditionNum);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
