import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../DoctorProfile.dart';
import '../uploadPres.dart';
String getCurrentDate() {
  // Get the current date and format it as "dd/MM/yyyy"
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd/MM/yyyy').format(now);
  return formattedDate;
}





Widget listTile(doctorId,BuildContext context,Name,Speciality,count,start,end,call,url){
  return  Container(width: 410,
    height: 280,
    child: Column(
      verticalDirection: VerticalDirection.down,
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              "$url",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. $Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              child: Text(
                                '$Speciality',
                                style: TextStyle(
                                  color: Color(0xFF778285),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 30, 0, 0),
                              child: Text(
                                '${count}Patients',
                                style: TextStyle(
                                  color: Color(0xFF778285),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.call,
                            color: Color(0xAE4B39EF),
                            size: 24,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 3, 0),
                              child: Icon(
                                Icons.star,
                                color: Color(0xFFFFC200),
                                size: 17,
                              ),
                            ),
                            Text(
                              '4.8',
                              style: TextStyle(
                                color: Color(0xFF778285),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                              child: VerticalDivider(
                                thickness: 1,
                                color: Color(0xFF778285),
                              ),
                            ),
                            Text(
                              '200 Reviews',
                              style: TextStyle(
                                color: Color(0xFF778285),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Icon(
                      Icons.access_time_sharp,
                      color: Color(0xFF778285),
                      size: 24,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      '$start',
                      style: TextStyle(
                        color: Color(0xFF778285),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: Icon(
                        Icons.timer_off_sharp,
                        color: Color(0xFF778285),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Text(
                  '$end',
                  style: TextStyle(
                    color: Color(0xFF778285),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TextButton(
                //   onPressed: () {
                //     print('Cancel Appointment Button pressed ...');
                //
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => UploadPrescription()),
                //       );
                //
                //   },
                //   child: Text(
                //     'Cancel Appointment',
                //     style: TextStyle(
                //       color: Colors.blue,
                //       fontSize: 12,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all<Color>(
                //       Colors.blue.withOpacity(0.1),
                //     ),
                //     // overlayColor: MaterialStateProperty.all<Color>(
                //     //   Colors.blue.withOpacity(0.1),
                //     // ),
                //   ),
                // ),
                TextButton(
                  onPressed: () {
                    print('Reschedule Button pressed ...');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorInfo(doctorName: Name,specialization:Speciality,doctorId:doctorId,),));
                    // addAppointmentRequest("qwer","sdf");
                    // setState(() {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => TabsPage()),
                    //   );
                    // });
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black,
                    ),
                    // overlayColor: MaterialStateProperty.all<Color>(
                    //   Colors.blue.withOpacity(0.1),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    ),
  );
}