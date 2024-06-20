import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlanetsPage extends StatefulWidget {
  @override
  _PlanetsPageState createState() => _PlanetsPageState();
}

class _PlanetsPageState extends State<PlanetsPage> {
  late Future<List<dynamic>> _planetsData;

  @override
  void initState() {
    super.initState();
    _planetsData = _fetchPlanetsData();
  }

  Future<List<dynamic>> _fetchPlanetsData() async {
    List<dynamic> allResults = [];
    String nextUrl = 'https://swapi.dev/api/planets/';

    while (nextUrl.isNotEmpty) {
      final response = await http.get(Uri.parse(nextUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> results = data['results'];
        allResults.addAll(results);
        nextUrl = data['next'] ?? '';
      } else {
        throw Exception('Failed to load data');
      }
    }

    return allResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<dynamic>>(
        future: _planetsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<dynamic> results = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                String name = results[index]['name'];
                String climate = results[index]['climate'];
                String terrain = results[index]['terrain'];
                String population = results[index]['population'];
                String diameter = results[index]['diameter'];
                String imageUrl =
                    'https://starwars-visualguide.com/assets/img/planets/${index + 1}.jpg';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlanetDetailsPage(
                          name: name,
                          climate: climate,
                          terrain: terrain,
                          population: population,
                          diameter: diameter,
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

class PlanetDetailsPage extends StatelessWidget {
  final String name;
  final String climate;
  final String terrain;
  final String population;
  final String diameter;
  final String imageUrl;

  PlanetDetailsPage({
    required this.name,
    required this.climate,
    required this.terrain,
    required this.population,
    required this.diameter,
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
              Text('Climate : $climate',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Terrain : $terrain',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Population : $population',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Diameter : $diameter km',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
            ],
          ),
        ),
      ),
    );
  }
}
