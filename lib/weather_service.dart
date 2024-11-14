import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather.dart';

class WeatherService {
  final String apiUrl = 'http://10.0.2.2:3000/api/weather';

  Future<Weather?> getWeather(String cityName) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?city=$cityName'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Decode the response as a Map, not a List
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        print(jsonResponse);

        // Pass the map directly to the Weather.fromJson method
        return Weather.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      return null;
    }
  }




  Future<void> addWeather(Weather weather) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(weather.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add weather data');
      }
    } catch (e) {
      print(e);
    }
  }
}

