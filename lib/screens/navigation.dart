import 'package:flutter/material.dart';
import 'people.dart';
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
        title: const Text('STAR WARS'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Planets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Species',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Starships',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Vehicles',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
