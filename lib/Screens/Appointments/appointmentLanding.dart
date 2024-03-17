import 'package:flutter/material.dart';
import 'package:usalife/Screens/Appointments/screem.dart';

import 'Upcoming.dart';


class AppointementLandingPage extends StatefulWidget {
  const AppointementLandingPage({super.key});

  @override
  State<AppointementLandingPage> createState() => _AppointementLandingPageState();
}

class _AppointementLandingPageState extends State<AppointementLandingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: "Doctors",),
              Tab(text: "Appointment",),

            ],
          ),
          title: Text('Explore',style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 20
          ),),
        ),
        body: TabBarView(
          children: [
            AppointmentWidget(),
            AppointmentBooked(),

          ],
        ),
      ),
    );
  }
}
