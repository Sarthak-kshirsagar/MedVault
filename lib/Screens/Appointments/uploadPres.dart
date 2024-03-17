import 'graph.dart';
import 'package:flutter/material.dart';


class UploadPrescription extends StatefulWidget {
  const UploadPrescription({super.key});

  @override
  State<UploadPrescription> createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Prescription',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey.shade800,fontSize: 22),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey.shade700,

                  ),
                  onPressed: () {
                    //todo search within prescriptions
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text('Please Upload Valid Prescription\nimage from a Certified doctor.',textAlign: TextAlign.center ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text('Always upload a clear copy of your prescription',textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.grey.shade700),),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(style: BorderStyle.solid,color: Colors.grey,width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload,color: Colors.deepPurpleAccent.shade200,size: 50,),
                  SizedBox(height: 3),
                  Text('Upload Your Prescription Here',style: TextStyle(fontWeight: FontWeight.w900,color:Colors.grey.shade800 ),),
                  SizedBox(height: 20),
                  ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurpleAccent.shade200),),

                    onPressed: () {
                      //Todo upload prescription
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Graph()),
                        );
                      });
                    }, child: Text('Upload Here',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),)
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(style: BorderStyle.solid,color: Colors.grey,width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,0),
                    child: Icon(Icons.cloud,color: Colors.grey.shade600,),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),elevation: MaterialStatePropertyAll(0),),
                    onPressed: () {
                      //todo show uploaded prescriptions
                    }, child: Text('Uploaded Prescriptions'),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
