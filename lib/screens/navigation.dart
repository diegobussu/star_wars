import 'package:flutter/material.dart';
import 'people.dart';
import 'planets.dart';
import 'species.dart';
import 'starships.dart';
import 'vehicles.dart';
import 'settings.dart'; // Import the SettingsPage

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    SpeciesPage(), // Index 0: SpeciesPage
    PeoplePage(), // Index 1: PeoplePage
    PlanetsPage(), // Index 2: PlanetsPage
    StarshipsPage(), // Index 3: StarshipsPage
    VehiclesPage(), // Index 4: VehiclesPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Star Wars Wiki',
          style: TextStyle(
            color: Color.fromRGBO(238, 191, 47, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Color.fromRGBO(238, 191, 47, 1)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/species_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 0
                  ? const Color.fromRGBO(238, 191, 47, 1)
                  : const Color.fromRGBO(238, 191, 47, 1),
            ),
            label: 'Species',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/people_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 1
                  ? const Color.fromRGBO(238, 191, 47, 1)
                  : const Color.fromRGBO(238, 191, 47, 1),
            ),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/planets_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 2
                  ? const Color.fromRGBO(238, 191, 47, 1)
                  : const Color.fromRGBO(238, 191, 47, 1),
            ),
            label: 'Planets',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/starships_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 3
                  ? const Color.fromRGBO(238, 191, 47, 1)
                  : const Color.fromRGBO(238, 191, 47, 1),
            ),
            label: 'Starships',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/vehicles_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 4
                  ? const Color.fromRGBO(238, 191, 47, 1)
                  : const Color.fromRGBO(238, 191, 47, 1),
            ),
            label: 'Vehicles',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(238, 191, 47, 1),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
    );
  }
}
