import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weather});

  final weather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel = WeatherModel();
  WeatherModel weathermessage = WeatherModel();
  String city;
  int temprature;
  String weathericon;
  String message;

  @override
  void initState() {
    super.initState();
    updateui(widget.weather);
  }

  void updateui(dynamic weatherdata){

    setState(() {
      if(weatherdata == null){
        temprature = 0;
        city = '';
        weathericon = 'error';
        message = 'server down';
        return;

      }
      city = weatherdata['name'];
      var id = weatherdata['weather'][0]['id'];
      weathericon = weatherModel.getWeatherIcon(id);
      double temp = weatherdata['main']['temp'];
      temprature = temp.round();
      message = weatherModel.getMessage(temprature);


    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherdata = await weatherModel.getlocationweather();
                      updateui(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()async{
                      var typedname = await Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));
                      if(typedname != null){
                        var weatherdata = weatherModel.getcityweather(typedname);
                        updateui(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Expanded(
                      child: Text(
                        '$weathericon️',
                        style: kConditionTextStyle,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Expanded(
                child: Text(
                  "$message",
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: Text(
                  '$city',
                  textAlign: TextAlign.left,
                  style: kCityname,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
