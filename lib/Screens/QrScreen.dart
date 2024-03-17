import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';






class QrScreenUi extends StatefulWidget {
  @override
  State<QrScreenUi> createState() => _QrScreenUiState();
}

class _QrScreenUiState extends State<QrScreenUi> {String name = 'Atharva Galne';
String bloodGroup = 'B+';
String dob = '24-09-2002';
String allergies = 'None';
String emergencyContact = '9028298790';

String selectedGender = '';
String currentMediactions = '';
Future<void> fetchProfileDataFromFirestore() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String userId = auth.currentUser!.uid;

  try {
    QuerySnapshot querySnapshot = await firestore
        .collection('profile')
        .where('PatientId', isEqualTo: userId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      setState(() {
        // Update variables with fetched data
        name = data['fullName'];
        selectedGender = data['gender'];
        bloodGroup = data['bloodType'];
        currentMediactions = data['currentMedications'];
        emergencyContact = data['EmergencyNumber'];
        dob = data['dob'];

        // Update other variables as needed
      });
    } else {
      print('Document does not exist');
    }
  } catch (e) {
    print('Error fetching profile data: $e');
  }
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vault Card',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vault Card',),
        ),
        body: Center(
          child: SingleChildScrollView(scrollDirection: Axis.vertical,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImageView(
                  data: 'Name: $name\n'
                      'Blood Group: $bloodGroup\n'
                      'Dob: $dob\n'
                      'Allergies: $allergies\n'
                      'Emergency contact: $emergencyContact\n',

                  version: QrVersions.auto,
                  size: 320,
                  gapless: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  child: Text('Name: $name\n'
                      'Blood Group: $bloodGroup\n'
                      'Dob: $dob\n'
                      'Allergies: $allergies\n'
                      'Emergency contact: $emergencyContact\n'
                      ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}