// import 'package:flutter/material.dart';
//
//
// class Reports extends StatefulWidget {
//   const Reports({Key? key}) : super(key: key);
//
//   @override
//   State<Reports> createState() => _ReportsState();
// }
//
// class _ReportsState extends State<Reports> {
//   String selectedHospital='Hospital A';
//   String selectedMedicalReport='Report 1';
//
//   List<String> hospitals = ['Hospital A', 'Hospital B', 'Hospital C']; // Add your hospital names here
//   List<String> medicalReports = ['Report 1', 'Report 2', 'Report 3']; // Add your medical report names here
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//
//         body: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: DropdownButtonFormField(
//                   value: selectedHospital,
//                   items: hospitals.map((hospital) {
//                     return DropdownMenuItem(
//                       value: hospital,
//                       child: Text(hospital),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedHospital = value.toString();
//                     });
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Select Hospital',
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: DropdownButtonFormField(
//                   value: selectedMedicalReport,
//                   items: medicalReports.map((report) {
//                     return DropdownMenuItem(
//                       value: report,
//                       child: Text(report),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedMedicalReport = value.toString();
//                     });
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Select Department',
//                   ),
//                 ),
//               ),
//
//               Wrap(
//                 spacing: 15,
//                 runSpacing: 15,
//                 children: [
//                   pdfTile("X Ray"),
//                   pdfTile("X Ray"),
//                   pdfTile("X Ray"),
//                   pdfTile("X Ray"),
//                   pdfTile("X Ray"),
//                 ],
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget pdfTile(Name){
//     return InkWell(
//       onTap: (){},
//       child: Container(
//         width: 100,
//         height: 150,
//         decoration: BoxDecoration(
//             border: Border.all(
//                 color: Colors.grey
//             ),
//             borderRadius: BorderRadius.circular(15)
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.file_copy,size: 50,),
//               SizedBox(height: 20,),
//               Text("$Name",style: TextStyle(
//                   fontWeight: FontWeight.bold,fontSize: 18,color: Colors.purple
//               ),)
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:usalife/Screens/medicalInfo.dart';



class ListOfAllPateintVisits extends StatefulWidget {
  const ListOfAllPateintVisits({super.key});

  @override
  State<ListOfAllPateintVisits> createState() => _ListOfAllPateintVisitsState();
}

class _ListOfAllPateintVisitsState extends State<ListOfAllPateintVisits> {
  bool isLoading = false;
  List<Map<String, dynamic>> conversationList1 = [];
  Map<dynamic,dynamic> patientConversationData = {};
  Future<void> getUserMedicalHistory() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String id = _auth.currentUser!.uid;
    print(id);
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore storage = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await storage
        .collection("PatientDoctorConversation")
        .where("PatientId", isEqualTo: "asdfg")
        .get();
    Map<dynamic, dynamic> conversationData = {};
    if (snapshot.docs.isNotEmpty) {
      // Retrieve the first document assuming there's only one with the same PatientId
      QueryDocumentSnapshot document = snapshot.docs.first;

      // Add all document data to the map
      conversationData = document.data() as Map<dynamic, dynamic>;
      setState(() {
        patientConversationData = conversationData;
      });
      print("data fetched");
      print(conversationData);
      setState(() {
        isLoading = false;
      });
    } else {
      print('No documents found for PatientId');
      setState(() {
        isLoading = false;
      });
    }
  }
  String useerId = "";

  Future<List<Map<String, dynamic>>> getUserMedicalHistoryLists(String patientId) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String id = auth.currentUser!.uid;
      setState(() {
        useerId = id;
      });
      print("id is");
      print(id);
    } on Exception catch (e) {
      print(e);
    }
    print("hi");
    try {
      setState(() {
        isLoading = true;
      });
      FirebaseFirestore storage = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await storage
          .collection("PatientDoctorConversation")
          .where("PatientId", isEqualTo: patientId)
          .get();

      List<Map<String, dynamic>> conversationList = [];


      if (snapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in snapshot.docs) {
          Map<String, dynamic> conversationData = document.data() as Map<String, dynamic>;
          conversationList.add(conversationData);

        }
        setState(() {
          conversationList1 = conversationList;
          isLoading = false;
        });
      } else {
        print('No documents found for PatientId');
        setState(() {
          isLoading = false;
        });
      }
      print(conversationList[1]);
      return conversationList;
    } catch (e) {
      print('Error fetching data: $e');
      isLoading = false;
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserMedicalHistoryLists("${useerId}");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading?Center(child: CircularProgressIndicator(),):Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [


              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Your Visits",style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 23
                ),),
              ),
              SizedBox(height: 50,),
              InkWell(onTap: (){
                getUserMedicalHistoryLists("${useerId}");
              },child: Icon(Icons.refresh)),
              SizedBox(height: 20,),
              Container(
                height: 500,
                child: ListView.builder(itemCount: conversationList1.length,itemBuilder: (context, index) {
                  return Column(

                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalTiles(patientConversationData:conversationList1[index],),));
                        },
                        child: Container(
                          width: 250,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,

                            ),
                            borderRadius: BorderRadius.circular(15),

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(

                                children: [
                                  Image.asset(width:80,height:80,"assets/doctor.jpg"),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: [
                                      Text("${conversationList1[index]["DoctorName"]}",style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 15
                                      ),),
                                      SizedBox(height:10,),
                                      Text("${conversationList1[index]["Category"]}",style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 15
                                      ),),
                                      SizedBox(height:10,),
                                      Text("${conversationList1[index]["Date"]}",style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 15
                                      ),)

                                    ],
                                  )
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,)

                    ],
                  );
                },),
              )
            ],
          ),
        ),
      ),
    );
  }
}
