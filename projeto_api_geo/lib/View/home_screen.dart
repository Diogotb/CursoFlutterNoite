import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_api_geo/Service/weather_service_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> _weatherData = {};
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWeatherInit();
  }

  Future <void> _getWeatherInit() async{
    try {
      print("sem localizaçao");
      Position position = await Geolocator.getCurrentPosition();
      print(position.latitude);
      _weatherData = await _weatherService.getWeatherByLocation(
        position.latitude, position.longitude
        );
      print("weather ok");
      setState(() {
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Previsão do Tempo"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Pesquisar")),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Favoritos"))
                  ],
                ),
                const SizedBox(height: 20),
                _weatherData.isEmpty
                    ? Row(
                        children: [
                          const Text("Erro de Conexão"),
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: () {
                              _getWeatherInit();
                            },
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Text(_weatherData["name"]),
                          const SizedBox(height: 10),
                          Text(_weatherData["weather"][0]["description"]),
                          const SizedBox(height: 10),
                          Text((_weatherData["main"]["temp"]-273).toString()),
                          const SizedBox(height: 10),
                        ],
                      )
              ],
            )));
  }
}
