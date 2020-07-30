import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const String apikey = '51c50b2dbab96f7460f6c24c03935fd9';

class WeatherModel {

    Future<dynamic> getcityweather(String typedname) async {

    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$typedname&appid=$apikey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);

    var weatherdata = await networkHelper.getData();
    return weatherdata;
  }//maybe

  double latitude;
  double longitude;


  Future<dynamic> getlocationweather()async{
    Location currentlocation = Location();

    await currentlocation.getcurrentlocation();
    latitude = currentlocation.latitude;
    longitude = currentlocation.longitude;


    NetworkHelper networkHelper = NetworkHelper(url: 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
    var weatherdata = await networkHelper.getData();

    return weatherdata;
  }

  String getWeatherIcon(int condition) {


    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time in';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in';
    } else {
      return 'Bring a 🧥 just in case in';
    }
  }
}
