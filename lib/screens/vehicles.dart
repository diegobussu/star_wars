import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VehiclesPage extends StatefulWidget {
  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclesPage> {
  late Future<Map<String, dynamic>> _vehiclesData;

  @override
  void initState() {
    super.initState();
    _vehiclesData = _fetchVehiclesData();
  }

  Future<Map<String, dynamic>> _fetchVehiclesData() async {
    final response =
        await http.get(Uri.parse('https://swapi.dev/api/vehicles/'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _vehiclesData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          } else {
            List<dynamic> results = snapshot.data!['results'];
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                String name = results[index]['name'];
                String model = results[index]['model'];
                String vehicleClass = results[index]['vehicle_class'];
                String manufacturer = results[index]['manufacturer'];
                String costInCredits = results[index]['cost_in_credits'];
                String length = results[index]['length'];
                String crew = results[index]['crew'];
                String passengers = results[index]['passengers'];
                String maxAtmospheringSpeed =
                    results[index]['max_atmosphering_speed'];
                String cargoCapacity = results[index]['cargo_capacity'];
                String consumables = results[index]['consumables'];
                String imageUrl =
                    'https://starwars-visualguide.com/assets/img/vehicles/${index + 1}.jpg';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VehicleDetailsPage(
                          name: name,
                          model: model,
                          vehicleClass: vehicleClass,
                          manufacturer: manufacturer,
                          costInCredits: costInCredits,
                          length: length,
                          crew: crew,
                          passengers: passengers,
                          maxAtmospheringSpeed: maxAtmospheringSpeed,
                          cargoCapacity: cargoCapacity,
                          consumables: consumables,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(238, 191, 47, 1)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class VehicleDetailsPage extends StatelessWidget {
  final String name;
  final String model;
  final String vehicleClass;
  final String manufacturer;
  final String costInCredits;
  final String length;
  final String crew;
  final String passengers;
  final String maxAtmospheringSpeed;
  final String cargoCapacity;
  final String consumables;
  final String imageUrl;

  VehicleDetailsPage({
    required this.name,
    required this.model,
    required this.vehicleClass,
    required this.manufacturer,
    required this.costInCredits,
    required this.length,
    required this.crew,
    required this.passengers,
    required this.maxAtmospheringSpeed,
    required this.cargoCapacity,
    required this.consumables,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(color: Color.fromRGBO(238, 191, 47, 1)),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color.fromRGBO(238, 191, 47, 1)),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              SizedBox(height: 20),
              Text('Model : $model',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Vehicle Class : $vehicleClass',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Manufacturer : $manufacturer',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Cost in Credits : $costInCredits',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Length : $length',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Crew : $crew',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Passengers : $passengers',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Max Atmosphering Speed : $maxAtmospheringSpeed',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Cargo Capacity : $cargoCapacity',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Consumables : $consumables',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
            ],
          ),
        ),
      ),
    );
  }
}
