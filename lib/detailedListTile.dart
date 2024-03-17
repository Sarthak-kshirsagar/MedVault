import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Screens/medicalInfo.dart';

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
  Future<List<Map<String, dynamic>>> getUserMedicalHistoryLists(String patientId) async {
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
    getUserMedicalHistoryLists("asdfg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading?Center(child: CircularProgressIndicator(),):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Your Visits",style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 23
            ),),
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
    );
  }
}
