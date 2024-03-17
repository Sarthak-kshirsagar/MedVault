import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HospitalInfo extends StatefulWidget {
  String doctorId = '';
  String doctorName = '';
  String specialization = '';
  String logo = '';
  String image = '';


  HospitalInfo({required this.logo,required this.image,required this.doctorId,required this.doctorName, required this.specialization});

  @override
  State<HospitalInfo> createState() => _HospitalInfoState();
}

class _HospitalInfoState extends State<HospitalInfo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late FToast fToast;
  Future<void> addAppointmentRequest(String doctorName, String doctorId) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String patientId = auth.currentUser!.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Check if the patientId already exists in the Requests sub-collection for the given doctor
      DocumentSnapshot<Map<String, dynamic>> doctorSnapshot = await firestore
          .collection("DoctorWiseAppointment")
          .doc()
          .get();

      if (doctorSnapshot.exists) {
        List<Map<String, dynamic>>? requests = (doctorSnapshot.data()?["Requests"] as List?)?.cast<Map<String, dynamic>>();

        if (requests != null && requests.any((req) => req["PatientId"] == patientId)) {

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Already Requested! Kindly check the Appointment Tab"),
          ));

          print('PatientId $patientId already exists for DoctorId $doctorId');
        } else {
          // Add a new request to the existing doctor document
          await firestore.collection("DoctorWiseAppointment").doc().update({
            "Requests": FieldValue.arrayUnion([
              {
                "PatientId": patientId,
                "status": false,
                // Add other fields as needed
              }
            ])
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orange,
            content: Text("Request Sent, Kindly Check the Appointment status under Appointments Tab, Thanks!"),
          ));

          print('Appointment request added for DoctorId: $doctorId and PatientId: $patientId');
        }
      } else {
        // Add a new document for the doctor and the request
        await firestore.collection("DoctorWiseAppointment").doc().set({
          "DoctorId": doctorId,
          "Doctor Name": doctorName,
          "Requests": [
            {
              "PatientId": patientId,
              "status": false,
              // Add other fields as needed
            }
          ]
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Request Sent, Kindly Check the Appointment status under Appointments Tab, Thanks!"),
        ));

        print('Appointment request added for DoctorId: $doctorId and PatientId: $patientId');
      }
    } catch (e) {
      print('Error adding appointment request: $e');
    }
  }

  // Future<void> addAppointmentRequest(String doctorName,String doctorId, String patientId) async {
  //   try {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //     // Check if the patientId already exists in the Appointment collection for the given doctor
  //     FirebaseAuth _auth = FirebaseAuth.instance;
  //     print(_auth.currentUser!.uid);
  //     QuerySnapshot patientSnapshot = await firestore
  //         .collection("Appointment")
  //
  //         .where("Requests.PatientId", isEqualTo: patientId)
  //         .get();
  //
  //     if (patientSnapshot.docs.isNotEmpty) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("Already Requested ! Kindly check the Appointment Tab")));
  //
  //       print('PatientId $patientId already exists for DoctorId $doctorId');
  //     } else {
  //       // Add a new document under "Appointment" collection
  //       await firestore.collection("DoctorWiseAppointment").add({
  //         "DoctorId": doctorId,
  //         "Doctor Name": doctorName,
  //         "Requests": [
  //           {
  //             "PatientId": patientId,
  //             "status": false,
  //             // Add other fields as needed
  //           }
  //         ]
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text("Request Sent,Kindly Check the Appointemnt status under Appointments Tab,Thanks!")));
  //
  //
  //       print('Appointment request added for DoctorId: $doctorId and PatientId: $patientId');
  //     }
  //   } catch (e) {
  //     print('Error adding appointment request: $e');
  //   }
  // }
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
  }
  void showToast(message) {
    Fluttertoast.showToast(
      msg: '$message',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              child: Image.asset("${widget.image}",height: 300,fit: BoxFit.fill,)
            ),
            Container(
              height: 340,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.2), // Set opacity to 50%
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height * 0.32, 0, 0),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(70),
                      ),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: AssetImage("${widget.logo}")),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${widget.doctorName.substring(0,8)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        '${widget.specialization}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.15),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  child: IconButton(
                                                    icon: Icon(Icons.call,
                                                        color: Colors
                                                            .blue), // Icon widget
                                                    onPressed: () {
                                                      //todo call button
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange
                                                          .withOpacity(0.15),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  child: IconButton(
                                                    icon: Icon(Icons.message,
                                                        color: Colors
                                                            .orange), // Icon widget
                                                    onPressed: () {
                                                      //todo message button
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                    Colors.red.withOpacity(0.15),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(Icons.video_chat,
                                                        color: Colors
                                                            .red), // Icon widget
                                                    onPressed: () {
                                                      //todo Videocall button
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'About Hospital',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                            ),
                          ),
                          Wrap(
                            children: [
                              Text(
                            "Deenanath Mangeshkar Hospital & Research Center is a charitable, multi-specialty hospital located in the heart of Pune, India. Founded in 2001, today it is one of the largest hospital in Pune, with 800 beds. Deenanath Mangeshkar Hospital offers state-of-the-art diagnostic, therapeutic and intensive care facilities in a one-stop medical center."


    ,style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Upcoming Schedules',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.15),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '12',
                                            style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            'Jan',
                                            style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Consultation',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      ),
                                      Text('Sunday.  9am - 11am'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.15),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '13',
                                            style: TextStyle(
                                                color: Colors.orange.shade800,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            'Jan',
                                            style: TextStyle(
                                                color: Colors.orange.shade800,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Consultation',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      ),
                                      Text('Monday.  9am - 11am'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 100,vertical: 10)),
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.green.shade600),
                                    foregroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                                onPressed: () {
                                  // _auth.currentUser!.uid.toString()
                                  addAppointmentRequest(widget.doctorName,widget.doctorId);
                                },
                                child: Text(
                                  'Book Appointment',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}