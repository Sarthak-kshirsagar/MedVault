// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class MedicalInfoForm extends StatefulWidget {
//   const MedicalInfoForm();
//   @override
//   _MedicalInfoFormState createState() => _MedicalInfoFormState();
// }
//
// class _MedicalInfoFormState extends State<MedicalInfoForm> {
//   TextEditingController ongoingMedicalConditionsController = TextEditingController();
//   TextEditingController currentMedicationsController = TextEditingController();
//   TextEditingController surgeriesController = TextEditingController();
//   TextEditingController medicalDevicesController = TextEditingController();
//   TextEditingController familyMedicalHistoryController = TextEditingController();
//   TextEditingController healthcareProvidersController = TextEditingController();
//   TextEditingController insuranceProviderController = TextEditingController();
//   TextEditingController policyNumberController = TextEditingController();
//   TextEditingController authorizationInfoController = TextEditingController();
//   TextEditingController advanceDirectivesController = TextEditingController();
//
//   List<String> genders = ['Male', 'Female'];
//   String selectedGender='Male';
//
//   List<String> bloodTypes = ['A', 'B', 'AB', 'O'];
//   String selectedBloodType='A';
//
//   List<String> ongoingMedicalConditions = [
//     'Heart Disease',
//     'Hypertension',
//     'Diabetes',
//     'Asthma',
//     'Epilepsy',
//   ];
//   String selectedOngoingMedicalCondition='Heart Disease';
//
//   Future<void> saveProfileDataToFirestore(
//       String fullName,
//       String dob,
//       String gender,
//       String bloodType,
//       String emergencyContacts,
//       String aadharNumber,
//       String ongoingMedicalConditions,
//       String selectedHospital,
//       String selectedMedicalReport,
//       String selectedMedicalSpecialty,
//       // Add other parameters as needed
//       ) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//     String userId = auth.currentUser!.uid;
//
//     try {
//       await firestore.collection('profile').doc(userId).set({
//         'fullName': fullName,
//         'dob': dob,
//         'gender': gender,
//         'bloodType': bloodType,
//         'emergencyContacts': emergencyContacts,
//         'aadharNumber': aadharNumber,
//         'ongoingMedicalConditions': ongoingMedicalConditions,
//         'selectedHospital': selectedHospital,
//         'selectedMedicalReport': selectedMedicalReport,
//         'selectedMedicalSpecialty': selectedMedicalSpecialty,
//         // Add other fields as needed
//       });
//     } catch (e) {
//       print('Error saving profile data: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20,),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("Profile",style: TextStyle(
//                 fontWeight: FontWeight.bold,fontSize: 25
//               ),),
//             ),
//             DropdownButtonFormField(
//               value: selectedGender,
//               items: genders.map((gender) {
//                 return DropdownMenuItem(
//                   value: gender,
//                   child: Text(gender),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedGender = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Gender',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             DropdownButtonFormField(
//               value: selectedBloodType,
//               items: bloodTypes.map((type) {
//                 return DropdownMenuItem(
//                   value: type,
//                   child: Text(type),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedBloodType = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Blood Type',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             DropdownButtonFormField(
//               value: selectedOngoingMedicalCondition,
//               items: ongoingMedicalConditions.map((condition) {
//                 return DropdownMenuItem(
//                   value: condition,
//                   child: Text(condition),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedOngoingMedicalCondition = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Any ongoing medical conditions',
//               ),
//             ),
//             TextFormField(
//               controller: currentMedicationsController,
//               decoration: InputDecoration(labelText: 'Current medications (including dosage and frequency)'),
//             ),
//             TextFormField(
//               controller: surgeriesController,
//               decoration: InputDecoration(labelText: 'Previous surgeries or medical procedures'),
//             ),
//             TextFormField(
//               controller: medicalDevicesController,
//               decoration: InputDecoration(labelText: 'Any implanted medical devices'),
//             ),
//             TextFormField(
//               controller: familyMedicalHistoryController,
//               decoration: InputDecoration(labelText: 'Any relevant family medical history'),
//             ),
//             TextFormField(
//               controller: healthcareProvidersController,
//               decoration: InputDecoration(labelText: 'Healthcare Providers'),
//             ),
//             TextFormField(
//               controller: insuranceProviderController,
//               decoration: InputDecoration(labelText: 'Insurance Provider'),
//             ),
//             TextFormField(
//               controller: policyNumberController,
//               decoration: InputDecoration(labelText: 'Policy Number'),
//             ),
//             TextFormField(
//               controller: authorizationInfoController,
//               decoration: InputDecoration(labelText: 'Authorization Information'),
//             ),
//             TextFormField(
//               controller: advanceDirectivesController,
//               decoration: InputDecoration(labelText: 'Advance Directives or Living Will (if applicable)'),
//             ),
//             SizedBox(height: 16.0),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle form submission
//                   saveProfileDataToFirestore(
//                     fullNameController.text,
//                     dobController.text,
//                     selectedGender,
//                     selectedBloodType,
//                     emergencyContactsController.text,
//                     aadharController.text,
//                     selectedOngoingMedicalCondition,
//                     selectedHospital,
//                     selectedMedicalReport,
//                     selectedMedicalSpecialty,
//                     // Add other parameters as needed
//                   );
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(Colors.black),
//                   foregroundColor: MaterialStatePropertyAll(Colors.white)
//                 ),
//                 child: Text('Update'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//












import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MedicalInfoForm extends StatefulWidget {
  const MedicalInfoForm();
  @override
  _MedicalInfoFormState createState() => _MedicalInfoFormState();
}

class _MedicalInfoFormState extends State<MedicalInfoForm> {
  TextEditingController ongoingMedicalConditionsController = TextEditingController();
  TextEditingController currentMedicationsController = TextEditingController();
  TextEditingController surgeriesController = TextEditingController();
  TextEditingController medicalDevicesController = TextEditingController();
  TextEditingController familyMedicalHistoryController = TextEditingController();
  TextEditingController healthcareProvidersController = TextEditingController();
  TextEditingController insuranceProviderController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController authorizationInfoController = TextEditingController();
  TextEditingController advanceDirectivesController = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController emergencyContact = TextEditingController();
  TextEditingController dob = TextEditingController();

  List<String> genders = ['Male', 'Female'];
  String selectedGender='Male';

  List<String> bloodTypes = ['A', 'B', 'AB', 'O'];
  String selectedBloodType='A';

  List<String> ongoingMedicalConditionsList = [
    'Heart Disease',
    'Hypertension',
    'Diabetes',
    'Asthma',
    'Epilepsy',
  ];
  String selectedOngoingMedicalCondition='Heart Disease';

  Future<void> saveProfileDataToFirestore(
      String fullName,
      String emergencyNumber,
      String dob,
      String gender,
      String bloodType,
      String ongoingMedicalConditions,
      String currentMedications,
      String surgeries,
      String medicalDevices,
      String familyMedicalHistory,
      String healthcareProviders,
      String insuranceProvider,
      String policyNumber,
      String authorizationInfo,
      String advanceDirectives,
      ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String userId = auth.currentUser!.uid;

    try {
      await firestore.collection('profile').doc(userId).set({
        'PatientId':userId,
        'fullName': fullName,
        'EmergencyNumber':emergencyNumber,
        'dob': dob,
        'gender': gender,
        'bloodType': bloodType,
        'ongoingMedicalConditions': ongoingMedicalConditions,
        'currentMedications': currentMedications,
        'surgeries': surgeries,
        'medicalDevices': medicalDevices,
        'familyMedicalHistory': familyMedicalHistory,
        'healthcareProviders': healthcareProviders,
        'insuranceProvider': insuranceProvider,
        'policyNumber': policyNumber,
        'authorizationInfo': authorizationInfo,
        'advanceDirectives': advanceDirectives,
      });
    } catch (e) {
      print('Error saving profile data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Profile",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 25
              ),),
            ),
            TextFormField(
              controller: Name,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: emergencyContact,
              decoration: InputDecoration(labelText: 'Emergency Contact'),
            ),
            TextFormField(
              controller: dob,
              decoration: InputDecoration(labelText: 'DOB'),
            ),
            DropdownButtonFormField(
              value: selectedGender,
              items: genders.map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Gender',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: selectedBloodType,
              items: bloodTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBloodType = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Blood Type',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: selectedOngoingMedicalCondition,
              items: ongoingMedicalConditionsList.map((condition) {
                return DropdownMenuItem(
                  value: condition,
                  child: Text(condition),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedOngoingMedicalCondition = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Any ongoing medical conditions',
              ),
            ),
            TextFormField(
              controller: currentMedicationsController,
              decoration: InputDecoration(labelText: 'Current medications (including dosage and frequency)'),
            ),
            TextFormField(
              controller: surgeriesController,
              decoration: InputDecoration(labelText: 'Previous surgeries or medical procedures'),
            ),
            TextFormField(
              controller: medicalDevicesController,
              decoration: InputDecoration(labelText: 'Any implanted medical devices'),
            ),
            TextFormField(
              controller: familyMedicalHistoryController,
              decoration: InputDecoration(labelText: 'Any relevant family medical history'),
            ),
            TextFormField(
              controller: healthcareProvidersController,
              decoration: InputDecoration(labelText: 'Healthcare Providers'),
            ),
            TextFormField(
              controller: insuranceProviderController,
              decoration: InputDecoration(labelText: 'Insurance Provider'),
            ),
            TextFormField(
              controller: policyNumberController,
              decoration: InputDecoration(labelText: 'Policy Number'),
            ),
            TextFormField(
              controller: authorizationInfoController,
              decoration: InputDecoration(labelText: 'Authorization Information'),
            ),
            TextFormField(
              controller: advanceDirectivesController,
              decoration: InputDecoration(labelText: 'Advance Directives or Living Will (if applicable)'),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                  saveProfileDataToFirestore(

                   Name.text,
                    emergencyContact.text,
                    dob.text,

                    selectedGender,
                    selectedBloodType,
                    selectedOngoingMedicalCondition,
                    currentMedicationsController.text,
                    surgeriesController.text,
                    medicalDevicesController.text,
                    familyMedicalHistoryController.text,
                    healthcareProvidersController.text,
                    insuranceProviderController.text,
                    policyNumberController.text,
                    authorizationInfoController.text,
                    advanceDirectivesController.text,
                  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)
                ),
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
