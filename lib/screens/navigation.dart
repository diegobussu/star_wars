import 'package:flutter/material.dart';
import 'people.dart'; // Importez vos pages ici
import 'planets.dart';
import 'species.dart';
import 'starships.dart';
import 'vehicles.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PeoplePage(),
    PlanetsPage(),
    SpeciesPage(),
    StarshipsPage(),
    VehiclesPage(),
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
        title: Text('Star Wars Wiki'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/people_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 0
                  ? Color.fromRGBO(238, 191, 47, 1)
                  : Colors.black,
            ),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/planets_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 1
                  ? Color.fromRGBO(238, 191, 47, 1)
                  : Colors.black,
            ),
            label: 'Planets',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/species_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 2
                  ? Color.fromRGBO(238, 191, 47, 1)
                  : Colors.black,
            ),
            label: 'Species',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/starships_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 3
                  ? Color.fromRGBO(238, 191, 47, 1)
                  : Colors.black,
            ),
            label: 'Starships',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/vehicles_icon.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 4
                  ? Color.fromRGBO(238, 191, 47, 1)
                  : Colors.black,
            ),
            label: 'Vehicles',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(238, 191, 47, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
