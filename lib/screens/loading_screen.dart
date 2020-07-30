import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    currentlocation();
  }
  void currentlocation() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherdata = await weatherModel.getlocationweather();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(weather: weatherdata,)));
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: SpinKitWave(
            size: 100,
            color: Colors.blueGrey,
          ),
        ),
      );

  }
}
