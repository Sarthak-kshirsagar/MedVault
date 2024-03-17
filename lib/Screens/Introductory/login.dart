import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:usalife/Screens/Introductory/register.dart';

import '../../detailedListTile.dart';
import '../Dashboard/dashboard.dart';
import '../contractInteraction.dart';
import '../medicalInfo.dart';
import '../quthScreen.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// ElevatedButton(onPressed: (){
//   Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
// }, child: Text("press mi")),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("MedVault",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize:28
                ),),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterCarousel(

                    options: CarouselOptions(

                      height: 400.0,
                      showIndicator: true,
                      slideIndicator: CircularSlideIndicator(alignment:Alignment.center,indicatorBackgroundColor: Colors.grey,currentIndicatorColor: Colors.green),
                    ),
                    items: [sliderImages("assets/doctor.jpg","Connect with Doctors"),
                      sliderImages("assets/img1.jpg","Connect with Doctors"),
                      sliderImages("assets/img2.jpg","Connect with Doctors"),
                      sliderImages("assets/img4.png","Connect with Doctors"),

                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                    // color: Colors.amber
                              ),
                              child:i,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text("Let's get Started! Enter your Mobile Number",style: TextStyle(
        fontWeight: FontWeight.bold,fontSize:18,color: Colors.grey.shade500
      ),),
    ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  width: 250,
                  child: TextField(
controller: _phoneNumber,
                    decoration: InputDecoration(

                      label: Text("Enter Mobile Number"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,width: 0.5
                        ),
                        borderRadius: BorderRadius.circular(25),


                      ),
                      prefixIcon: Icon(Icons.contacts),

                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: ElevatedButton(style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)
                ),onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneAuthScreen(phoneNumber: _phoneNumber.text,),));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneAuthScreen(phoneNumber: _phoneNumber.text,),));
                }, child: Text("Proceed")),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget sliderImages(imagePath,Info){
    return Container(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(width: 450,height: 250,"$imagePath"),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(left:50)
            ,                      child: Text("$Info",style: TextStyle(
              fontWeight: FontWeight.bold,fontSize:22
          ),),
          )
        ],
      ),
    );
  }
}


