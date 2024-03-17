import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:usalife/Screens/Dashboard/ActualDahboard.dart';
import 'package:usalife/Screens/Introductory/register.dart';

import 'Dashboard/dashboard.dart';





class PhoneAuthScreen extends StatefulWidget {
  String phoneNumber = '';
  PhoneAuthScreen({required this.phoneNumber});
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String _verificationId = '';
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phoneNumber.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          print('Phone number automatically verified and signed in');
          Fluttertoast.showToast(msg: 'Phone number automatically verified and signed in');
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ThanksForRegistering(),), (route) => false);
        },
        verificationFailed: (FirebaseAuthException authException) {
          print('Phone number verification failed: ${authException.message}');
          Fluttertoast.showToast(msg: 'Phone number verification failed: ${authException.message}');
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          print('Verification code sent to the phone number: $verificationId');
          Fluttertoast.showToast(msg: 'Verification code sent to the phone number');
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Auto retrieval timeout, verification ID: $verificationId');
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      print('Error during phone verification: $e');
      Fluttertoast.showToast(msg: 'Error during phone verification: $e');
    }
  }

  Future<void> _signInWithPhoneNumber() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      print('Phone number signed in successfully');
      Fluttertoast.showToast(msg: 'Phone number signed in successfully');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ThanksForRegistering(),), (route) => false);
    } catch (e) {
      print('Error during phone sign in: $e');
      Fluttertoast.showToast(msg: 'Error during phone sign in: $e');
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhoneNumber();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                Center(
                  child: Text("Verify Your Phone Number",style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                )
            ,              // ElevatedButton(
                //   onPressed: _verifyPhoneNumber,
                //   child: Text('Send OTP'),
                // ),
                SizedBox(height: 16.0),
                Center(
                  child: Container(
                    width: 250,
                    child: Center(
                      child: TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'OTP'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)
                      
                    ),
                    onPressed: _signInWithPhoneNumber,
                    child: Text('Verify OTP'),
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
