import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SpeciesPage extends StatefulWidget {
  @override
  _SpeciesPageState createState() => _SpeciesPageState();
}

class _SpeciesPageState extends State<SpeciesPage> {
  late Future<Map<String, dynamic>> _speciesData;

  @override
  void initState() {
    super.initState();
    _speciesData = _fetchSpeciesData();
  }

  Future<Map<String, dynamic>> _fetchSpeciesData() async {
    final response =
        await http.get(Uri.parse('https://swapi.dev/api/species/'));
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
        future: _speciesData,
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
                String classification = results[index]['classification'];
                String designation = results[index]['designation'];
                String averageHeight = results[index]['average_height'];
                String skinColors = results[index]['skin_colors'];
                String hairColors = results[index]['hair_colors'];
                String eyeColors = results[index]['eye_colors'];
                String averageLifespan = results[index]['average_lifespan'];
                String language = results[index]['language'];
                String imageUrl =
                    'https://starwars-visualguide.com/assets/img/species/${index + 1}.jpg';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpeciesDetailsPage(
                          name: name,
                          classification: classification,
                          designation: designation,
                          averageHeight: averageHeight,
                          skinColors: skinColors,
                          hairColors: hairColors,
                          eyeColors: eyeColors,
                          averageLifespan: averageLifespan,
                          language: language,
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

class SpeciesDetailsPage extends StatelessWidget {
  final String name;
  final String classification;
  final String designation;
  final String averageHeight;
  final String skinColors;
  final String hairColors;
  final String eyeColors;
  final String averageLifespan;
  final String language;
  final String imageUrl;

  SpeciesDetailsPage({
    required this.name,
    required this.classification,
    required this.designation,
    required this.averageHeight,
    required this.skinColors,
    required this.hairColors,
    required this.eyeColors,
    required this.averageLifespan,
    required this.language,
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
              Text('Classification : $classification',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Designation : $designation',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Average Height : $averageHeight cm',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Skin Colors : $skinColors',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Hair Colors : $hairColors',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Eye Colors : $eyeColors',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Average Lifespan : $averageLifespan years',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Language : $language',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
            ],
          ),
        ),
      ),
    );
  }
}
