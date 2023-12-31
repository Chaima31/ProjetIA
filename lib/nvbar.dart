import 'package:flutter/material.dart';
import 'package:najalichaimaetpai2/PageAjoutActivite.dart';
import 'package:najalichaimaetpai2/PageProfil.dart';
//import acceuil activite
import 'package:najalichaimaetpai2/AccueilEcran.dart';

//import 'package:projet/ListActivite.dart';
//import 'package:projet/MyProfile.dart';

class MyNavBarButtom extends StatefulWidget {
  const MyNavBarButtom({Key? key}) : super(key: key);

  @override
  State<MyNavBarButtom> createState() => _MyNavBarButtomState();
}

class _MyNavBarButtomState extends State<MyNavBarButtom> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ListeActivite(),
    const AjoutActivite(),
    const PageProfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: _currentIndex == 0
                  ? Color.fromARGB(255, 221, 12, 95)
                  : Colors.grey,
            ),
            label: "activity ",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: _currentIndex == 1
                  ? Color.fromARGB(255, 221, 12, 95)              : Colors.grey,
              size: 30,
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 2
                  ? Color.fromARGB(255, 221, 12, 95)
                  : Colors.grey,
              size: 30,
            ),
            label: "user",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(index);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}