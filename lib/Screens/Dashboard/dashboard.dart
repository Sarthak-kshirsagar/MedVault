import 'package:flutter/material.dart';
import 'package:usalife/Screens/QrScreen.dart';
import 'package:usalife/Screens/ai.dart';

import '../AiFeatures.dart';
import '../Appointments/appointmentLanding.dart';
import '../Appointments/profile.dart';
import '../Appointments/screem.dart';
import '../Appointments/tabs.dart';
import '../Reports.dart';
import 'ActualDahboard.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });}
  static const List<Widget> _pages = <Widget>[
    ActualDashboard(),
    // TabsPage(),
    AppointementLandingPage(),
    ListOfAllPateintVisits(),
    AiFeatures(),
    MedicalInfoForm(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => QrScreenUi(),));
      },child: Icon(Icons.qr_code),),
      bottomNavigationBar: BottomNavigationBar(

          onTap: _onItemTapped,
          currentIndex: _selectedIndex,

          selectedItemColor: Colors.green,items: <BottomNavigationBarItem>[

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.black

        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Appointments',
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Reports',
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_graph),
          label: 'Ai',
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
            backgroundColor: Colors.black
        ),
      ]),
      body: IndexedStack(
        index: _selectedIndex,
      children:_pages,
      ),
    );
  }
}
