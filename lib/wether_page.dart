import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool isLoading = false;
  final TextEditingController cityController = TextEditingController();
  num temp = 0;
  num press = 0;
  num hum = 0;
  num cover = 0;
  String cityname = 'Fetching weather data...';

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Weather App"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 249, 208),
              Color.fromARGB(255, 202, 244, 255),
              Color.fromARGB(255, 160, 222, 255),
              Color.fromARGB(255, 90, 178, 255),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cityController,
              cursorColor: Colors.black45,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              decoration: InputDecoration(
                border:const OutlineInputBorder(),
                labelText: 'Search City',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
                fillColor: Colors.white.withOpacity(0.7),
                filled: true,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.pin_drop,
                      color: Color.fromARGB(255, 7, 25, 82),
                      size: 40,
                    ),
                    Text(
                      cityname,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.12,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade900,
                    offset: Offset(1, 2),
                    blurRadius: 3,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage('image/thermometer.png'),
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Temperature: ${temp.toInt()} ºC',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.12,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade900,
                    offset: Offset(1, 2),
                    blurRadius: 3,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage('image/resilience.png'),
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pressure: $press hpa',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.12,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade900,
                    offset: Offset(1, 2),
                    blurRadius: 3,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage('image/humidity.png'),
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Humidity: $hum%',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.12,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade900,
                    offset: Offset(1, 2),
                    blurRadius: 3,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage('image/cloud-computing.png'),
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Cloud cover: $cover%',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                getCityWeather(cityController.text);
              },
              child: Text('Get Weather for City'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("By: Adli Ardhius salam")
          ],
        ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        forceAndroidLocationManager: true,
      );
      fetchWeatherData(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        cityname = "Failed to get location: $e";
        isLoading = false;
      });
    }
  }

  Future<void> fetchWeatherData(double lat, double lon) async {
    final apiKey = '76ab909095307f0dc3537c796e91114d';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        updateUI(jsonResponse);
      } else {
        setState(() {
          cityname = "Failed to load weather data: ${response.reasonPhrase}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        cityname = "Error: $e";
        isLoading = false;
      });
    }
  }

  Future<void> getCityWeather(String cityName) async {
    setState(() {
      isLoading = true;
    });
    final apiKey = '76ab909095307f0dc3537c796e91114d';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        updateUI(jsonResponse);
      } else {
        setState(() {
          cityname = "Failed to load weather data: ${response.reasonPhrase}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        cityname = "Error: $e";
        isLoading = false;
      });
    }
  }

  void updateUI(var decodedData) {
    setState(() {
      if (decodedData == null) {
        temp = 0;
        press = 0;
        hum = 0;
        cover = 0;
        cityname = 'Not available';
      } else {
        temp = decodedData['main']['temp'];
        press = decodedData['main']['pressure'];
        hum = decodedData['main']['humidity'];
        cover = decodedData['clouds']['all'];
        cityname = decodedData['name'];
      }
      isLoading = false;
    });
  }
}
