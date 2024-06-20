import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StarshipsPage extends StatefulWidget {
  @override
  _StarshipsPageState createState() => _StarshipsPageState();
}

class _StarshipsPageState extends State<StarshipsPage> {
  late Future<List<dynamic>> _starshipsData;

  @override
  void initState() {
    super.initState();
    _starshipsData = _fetchStarshipsData();
  }

  Future<List<dynamic>> _fetchStarshipsData() async {
    List<dynamic> allResults = [];
    String nextUrl = 'https://swapi.dev/api/starships/';

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
        future: _starshipsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
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
                String model = results[index]['model'];
                String manufacturer = results[index]['manufacturer'];
                String costInCredits = results[index]['cost_in_credits'];
                String length = results[index]['length'];
                String imageUrl =
                    'https://starwars-visualguide.com/assets/img/starships/${index + 1}.jpg';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StarshipDetailsPage(
                          name: name,
                          model: model,
                          manufacturer: manufacturer,
                          costInCredits: costInCredits,
                          length: length,
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

class StarshipDetailsPage extends StatelessWidget {
  final String name;
  final String model;
  final String manufacturer;
  final String costInCredits;
  final String length;
  final String imageUrl;

  StarshipDetailsPage({
    required this.name,
    required this.model,
    required this.manufacturer,
    required this.costInCredits,
    required this.length,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(
              color: Color.fromRGBO(238, 191, 47, 1),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color.fromRGBO(238, 191, 47, 1)),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              SizedBox(height: 20),
              Text('Model : $model\n',
                  style: const TextStyle(
                      color: Color.fromRGBO(238, 191, 47, 1),
                      fontWeight: FontWeight.bold)),
              Text('Manufacturer : $manufacturer\n',
                  style: const TextStyle(
                      color: Color.fromRGBO(238, 191, 47, 1),
                      fontWeight: FontWeight.bold)),
              Text('Cost in Credits : $costInCredits\n',
                  style: const TextStyle(
                      color: Color.fromRGBO(238, 191, 47, 1),
                      fontWeight: FontWeight.bold)),
              Text('Length : $length',
                  style: const TextStyle(
                      color: Color.fromRGBO(238, 191, 47, 1),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
