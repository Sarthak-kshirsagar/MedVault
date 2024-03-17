import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:usalife/Screens/pdfView.dart';

class MedicalTiles extends StatefulWidget {
  Map<dynamic,dynamic> patientConversationData = {};
   MedicalTiles({required this.patientConversationData});

  @override
  State<MedicalTiles> createState() => _MedicalTilesState();
}

class _MedicalTilesState extends State<MedicalTiles> {
  bool isLoading = false;






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/history.gif"),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),


                SizedBox(height: 20,),
                Center(
                  child: SingleChildScrollView(
                  
                    child: Container(
                      width: 300,
                      height: 320,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.8),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Text("Docoter Name:-     ${widget.patientConversationData["DoctorName"]}",style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize:15
                              ),),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Text("Doctoer Id :- ${widget.patientConversationData["DoctorId"]}",style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize:15
                                ),), Icon(Icons.copy)],
                              ),
                              Divider(),
                              ExpansionTile(
                                title: Text("Remarks",style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),),
                                children: [
                                  Text("${widget.patientConversationData["Remark"]}"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              Divider(),
                              Text("Reports",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Wrap(
                                spacing: 5,
                                runSpacing: 2,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      print("hi");

                                     Navigator.push(context, MaterialPageRoute(builder: (context) =>  PdfViewerPage(pdfUrl: "${widget.patientConversationData["Reports"]["Xrays"]}"),));

                                    },
                                    child: Text("Xray"),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(Colors.black),
                                        foregroundColor:
                                            MaterialStatePropertyAll(Colors.white)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {

                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  PdfViewerPage(pdfUrl: "${widget.patientConversationData["Reports"]["MRI"]}"),));

                                    },
                                    child: Text("MRI"),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(Colors.black),
                                        foregroundColor:
                                            MaterialStatePropertyAll(Colors.white)),
                                  ),

                                  Divider(),
                                  Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Next Visit",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      Text("asdlnklasnd"),
                                      Icon(Icons.schedule)
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
