import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  late Future<Map<String, dynamic>> _peopleData;

  @override
  void initState() {
    super.initState();
    _peopleData = _fetchPeopleData();
  }

  Future<Map<String, dynamic>> _fetchPeopleData() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people/'));
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
        future: _peopleData,
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
                String height = results[index]['height'];
                String mass = results[index]['mass'];
                String hairColor = results[index]['hair_color'];
                String skinColor = results[index]['skin_color'];
                String eyeColor = results[index]['eye_color'];
                String birthYear = results[index]['birth_year'];
                String gender = results[index]['gender'];
                String imageUrl =
                    'https://starwars-visualguide.com/assets/img/characters/${index + 1}.jpg';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailsPage(
                          name: name,
                          height: height,
                          mass: mass,
                          hairColor: hairColor,
                          skinColor: skinColor,
                          eyeColor: eyeColor,
                          birthYear: birthYear,
                          gender: gender,
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

class CharacterDetailsPage extends StatelessWidget {
  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final String imageUrl;

  CharacterDetailsPage({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
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
              Text('Height :  $height cm',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Mass : $mass kg',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Hair Color : $hairColor',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Skin Color : $skinColor',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Eye Color : $eyeColor',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Birth Year : $birthYear',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
              Text('Gender : $gender',
                  style:
                      const TextStyle(color: Color.fromRGBO(238, 191, 47, 1))),
            ],
          ),
        ),
      ),
    );
  }
}
