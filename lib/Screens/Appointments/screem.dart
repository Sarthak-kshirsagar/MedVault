import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Widgets/appointments.dart';

class AppointmentBooked extends StatefulWidget {
  const AppointmentBooked({super.key});

  @override
  State<AppointmentBooked> createState() => _AppointmentBookedState();
}

class _AppointmentBookedState extends State<AppointmentBooked> {

  // Future<List<Map<String, dynamic>>> getAppointmentListss(String patientId) async {
  //   try {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //     // Query all "DoctorWiseAppointment" documents for the specified PatientId
  //     QuerySnapshot querySnapshot = await firestore
  //         .collectionGroup("DoctorWiseAppointment")
  //         .where("Requests.PatientId", isEqualTo: patientId)
  //         .get();
  //
  //     List<Map<String, dynamic>> appointmentStatusList = [];
  //
  //     // Process each document found
  //     querySnapshot.docs.forEach((document) {
  //       document["Requests"].forEach((request) {
  //         Map<String, dynamic> appointment = {
  //           "PatientId": request["PatientId"],
  //           "status": request["status"],
  //         };
  //         appointmentStatusList.add(appointment);
  //       });
  //     });
  //     print(appointmentStatusList);
  //     return appointmentStatusList;
  //   } catch (e) {
  //     print('Error getting appointment status: $e');
  //     return [];
  //   }
  // }
  Future<void> getDoctorByPatientId(String patientId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot doctorSnapshot = await firestore
          .collection("DoctorWiseAppointment")
          .where("Requests.PatientId", isEqualTo: patientId)
          .get();

      if (doctorSnapshot.docs.isNotEmpty) {
        // Assuming there is only one doctor for a specific patient ID
        DocumentSnapshot<Map<String, dynamic>> doctorDocument = doctorSnapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>;

        // Access the doctor's data
        String doctorName = doctorDocument.data()?['Doctor Name']; // Assuming field name is "DoctorName"
        // String doctorId = doctorDocument.id; // Assuming you want to get the document ID

        print('Doctor Name: $doctorName');
      } else {
        print('No doctor found for patient ID: $patientId');
      }
    } catch (e) {
      print('Error retrieving doctor: $e');
    }
  }

  Future<void> getDoctorByPatientIDd(String patientId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot<Map<String, dynamic>> doctorSnapshot = await firestore
          .collection("DoctorWiseAppointment")
          .get();

      if (doctorSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doctorDocument in doctorSnapshot.docs) {
          // Check if data exists and is not null
          print("${doctorDocument.id}");
          if (doctorDocument.data() != null) {
            Map<String, dynamic>? doctorData = doctorDocument.data();
            print("$doctorData");
            FirebaseAuth _auth = FirebaseAuth.instance;
            String uid = _auth.currentUser!.uid;

            // Check if Requests sub-map exists and contains PatientId equal to 'asdf'
            if (doctorData?['Requests'] != null && doctorData?['Requests']['PatientId'] == '${uid}') {
              // Found the doctor document with the desired PatientId
              String doctorName = doctorData?['Doctor Name'] ?? 'Unknown'; // Default to 'Unknown' if DoctorName is null
              // String doctorId = doctorDocument.id; // Document ID

              print('Doctor Name: $doctorName');
              break; // Exit the loop since we found the desired document
            }
          }
        }
      } else {
        print('No doctors found in DoctorWiseAppointment collection.');
      }
    } catch (e) {
      print('Error retrieving doctors: $e');
    }
  }
// List<String> lisst = [];
//   Future<List<String>> getDoctorNamesByPatientId(String patientId) async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//     try {
//       QuerySnapshot<Map<String, dynamic>> doctorSnapshot = await firestore
//           .collection("DoctorWiseAppointment")
//           .get();
//
//       List<String> doctorNames = [];
//       print("printinfdsf"); print("printinfdsf");
//
//     print(doctorSnapshot.docs.first);
//       if (doctorSnapshot.docs.isNotEmpty) {
//         for (QueryDocumentSnapshot<Map<String, dynamic>> document in doctorSnapshot.docs) {
//           // Access the doctor name from each document and add it to the list
//           String doctorName = document.data()?['Doctor Name'] ?? 'Unknown';
//           bool status = document.data()?['Requests.status'] ?? false;
//           print("${doctorName}");
//           print("statusss");// Assuming field name is "Doctor Name"
//           print("${status}");
//           doctorNames.add(doctorName);
//         }
//       }
//       setState(() {
//         lisst = doctorNames;
//         print("printinfdsf");
//         print(lisst[0]);
//       });
//       return doctorNames;
//     } catch (e) {
//       print('Error getting doctor names: $e');
//       return [];
//     }
//   }

  List<String> lisst = [];
  List<bool> status = [];

  Future<List<String>> getDoctorNamesByPatientId(String patientId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot<Map<String, dynamic>> doctorSnapshot = await firestore
          .collection("DoctorWiseAppointment")
          .get();

      List<String> doctorNames = [];
      List<bool> doctorStatusList = [];

      if (doctorSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> document in doctorSnapshot.docs) {
          // Access the doctor name and status from each document and add them to the lists
          String doctorName = document.data()?['Doctor Name'] ?? 'Unknown';
          bool status = document.data()?['Requests'][0]['status'] ?? false; // Assuming status is inside a list under 'Requests'

          doctorNames.add(doctorName);
          doctorStatusList.add(status);

        }
      }

      setState(() {
        lisst = doctorNames;
        print(lisst[0]);
        status = doctorStatusList;
        print(status[0]);
      });

      // Optionally, you can return both doctor names and status
      return doctorNames;
    } catch (e) {
      print('Error getting doctor names: $e');
      return [];
    }
  }

// ===working =====

//   Future<String> getAppointmentStatus(String patientId) async {
//     print("hi");
//     try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
// print("gye");
//       // Query all "DoctorWiseAppointment" documents for the specified PatientId
//       QuerySnapshot querySnapshot = await firestore
//           .collection("DoctorWiseAppointment")
//           .where("Requests.PatientId", isEqualTo: patientId)
//           .get();
//       print("query");
//       // Check if any documents were found
//       if (querySnapshot.docs.isNotEmpty) {
//         // Assuming there's only one document for the patient in the requests
//         QueryDocumentSnapshot document = querySnapshot.docs.first;
//         print("hi");
//         print("${ document["Requests"]["status"].toString()}");
//         return document["status"].toString();
//       } else {
//         print("emoty");
//         return 'Not found';
//       }
//     } catch (e) {
//       print('Error getting appointment status: $e');
//       return 'Error';
//     }
//   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(getAppointmentStatus("qwww"));
    // getDoctorByPatientId("qwww");
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    getDoctorByPatientIDd("${uid}");
    getDoctorNamesByPatientId("${uid}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),


                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Your Appointments",style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                ),
      SizedBox(height: 20,),

                SizedBox(height: 20,),
                Container(
                  height: 500,
                  child: ListView.builder(itemCount: lisst.length,itemBuilder: (context, index) {
                    bool currentStatus = status[index];
                    return Column(
                      children: [
                        appointments("${lisst[index]}",currentStatus),
                      ],
                    );
                  },),
                ),
                // appointments("Atharva",true),
                // appointments("Atharva",false)
                // listTileAppointment(context,true),
                // listTileAppointment(context,false),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget appointments(name,bool status){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 0.6,


              ),
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade100
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.schedule),
                Text("Dr. $name",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize:15
                ),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(status==true)
                      ElevatedButton(style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),foregroundColor: MaterialStatePropertyAll(Colors.white)
                      ),onPressed: (){}, child: Text("Details")),
                    if(status==false)
                    Text("Pending",style: TextStyle(
                      color: Colors.red,fontWeight: FontWeight.bold
                    ),)
                  ],
                )

              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
