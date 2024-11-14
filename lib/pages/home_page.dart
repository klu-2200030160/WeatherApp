import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../weather_service.dart';
import 'package:weather_app_tutorial/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather('Vijayawada'); // Default city to load on startup
  }

  void _fetchWeather(String cityName) async {
    print("Hi i am sumanth");
    Weather? weather = await _weatherService.getWeather(cityName);
    print("bye");
    // Pass cityName to getWeather
    setState(() {
      _weather = weather;
    });
  }

  void _onSearch() {
    String cityName = _searchController.text.trim();
    if (cityName.isNotEmpty) {
      _fetchWeather(cityName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue[200],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 20,
                  child: Icon(Icons.cloud, color: Colors.white.withOpacity(0.8), size: 80),
                ),
                Positioned(
                  top: 100,
                  right: 40,
                  child: Icon(Icons.cloud, color: Colors.white.withOpacity(0.7), size: 60),
                ),
                Positioned(
                  top: 200,
                  left: 70,
                  child: Icon(Icons.sunny, color: Colors.deepOrange.withOpacity(0.6), size: 100),
                ),
                Positioned(
                  top: 300,
                  right: 90,
                  child: Icon(Icons.air_outlined, color: Colors.white.withOpacity(0.8), size: 70),
                ),
              ],
            ),
          ),
          // Main content
          Column(
            children: [
              _buildSearchBar(),
              Expanded(child: _buildUI()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 40.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Enter city name',
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search_sharp, color: Colors.black),
            onPressed: _onSearch,
          ),
        ),
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          color: Colors.black87,
        ),
        onSubmitted: (_) => _onSearch(),
      ),
    );
  }

  Widget _locationHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.black87,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            _weather?.city ?? "",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _locationHeader(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _dateTimeInfo(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            _weatherIcon(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            _currentTemp(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            _extraInfo(),
          ],
        ),
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "  ${DateFormat("d.M.y").format(now)}",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
              ),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.tempMax.toStringAsFixed(0)}° C", // Use tempMax as the current temperature
      style: const TextStyle(
        color: Colors.black,
        fontSize: 70,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Max: ${_weather?.tempMax.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                  fontSize: 15,
                ),
              ),
              Text(
                "Min: ${_weather?.tempMin.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                  fontSize: 15,
                ),
              ),
              Text(
                "Humidity: ${_weather?.humidity.toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
