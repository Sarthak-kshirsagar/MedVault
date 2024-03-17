import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:usalife/Screens/Appointments/uploadPres.dart';

import 'Widgets/doctortile.dart';



class AppointmentWidget extends StatefulWidget {
  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  List<dynamic> doctorsList = [];
  bool isLoading = false;
  Future<void> getDoctors()async{
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore doctorsRef = await FirebaseFirestore.instance;
    QuerySnapshot snapshot = await doctorsRef.collection("Doctors").get();

    if(snapshot.docs!=null){
      setState(() {
        doctorsList = snapshot.docs.toList();
        print(doctorsList[0]["Count"]);
        setState(() {
          isLoading = false;
        });
      });
    }else{
      print("error occured");
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctors();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading?Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      ),):SingleChildScrollView(
        child: Column(
          children: [
        
            Container(
              height:500,
              child: ListView.builder(itemCount: doctorsList.length,itemBuilder: (context, index) {
        
                return listTile("${doctorsList[index]["DoctorId"]}",context, "${doctorsList[index]["DoctorName"]}", "${doctorsList[index]["Speciality"]}", "${doctorsList[index]["Count"]}", "${doctorsList[index]["StartTime"]}", "${doctorsList[index]["EndTime"]}", "${doctorsList[index]["call"]}", "${doctorsList[index]["profileUrl"]}");
              },),
            )
            // listTile(context),
        
          ],
        ),
      ),
    );
  }

}
