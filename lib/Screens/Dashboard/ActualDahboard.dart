import 'package:flutter/material.dart';
import 'package:usalife/Screens/Appointments/appointmentLanding.dart';

import '../../detailedListTile.dart';
import '../Appointments/graph.dart';
import '../Appointments/hospitalLanding.dart';

class ActualDashboard extends StatefulWidget {
  const ActualDashboard({super.key});

  @override
  State<ActualDashboard> createState() => _ActualDashboardState();
}

class _ActualDashboardState extends State<ActualDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Featured Services",style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 23
              ),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
              spacing:15,
                children: [
                  Material(
                    elevation: 8,
                  borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AppointementLandingPage(),));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.2,
                        height: 280,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            children: [
                              Text("Connect with \ndoctors easily",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18
                              
                              ),),
                              SizedBox(height: 10,),
                      
                              SizedBox(height: 10,),
                              Image.asset(height: 200,"assets/doctor.jpg")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
        
                  Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListOfAllPateintVisits(),));

                        },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.2,
                        height: 280,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            children: [
                              Text(textAlign: TextAlign.center,"Track Medical Information",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18

                              ),),
                              SizedBox(height: 10,),

                              SizedBox(height: 10,),
                              Image.asset(height: 200,"assets/track.jpg")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(height:350,child: Graph()),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Not Feeling Well ?",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 23
              ),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey
              ),"Treat common symptons with our top specialist\njust in a click"),
            ),

            SizedBox(height: 20,),
            Center(
              child: Wrap(
                spacing:10,
                runSpacing: 10,
                children: [
                  servicesTile("assets/ent.jpg","ENT"),
                  servicesTile("assets/cardio.jpg","Cardiologist"),
                  servicesTile("assets/gyna.jpg","Gynalogist"),
                  servicesTile("assets/pulmoo.jpg","Pulmologist"),
                  servicesTile("assets/uro.jpg","Urologist"),
                  servicesTile("assets/ortho.jpg","Ortho"),
                  servicesTile("assets/neph.jpg","Nephrologist"),
                  servicesTile("assets/derma.jpg","Dermatologist"),
                ],
              ),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Popular Hospitals",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 23
              ),),
            ),
            SizedBox(height: 20,),
            Material(
              elevation: 3,
                borderRadius: BorderRadius.circular(20),

              child: InkWell(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalInfo(image: "assets/deena.jpg",logo: "assets/dmhlogo.jpg",doctorName: "DeenathMageshkar",doctorId: "asd",specialization: "Multispeciality",),));

                  },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width:MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: BoxDecoration(
                
                        color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                
                         children: [
                           Container(
                             width: 80,
                             height: 80,
                             decoration: BoxDecoration(
                               color: Colors.grey,
                               borderRadius: BorderRadius.circular(15)
                             ),
                      child: Image.asset("assets/derma.jpg"),
                           ),
                           SizedBox(width: 15,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Deenanath Mageshkar"),
                               Text("Pune"),
                               Text("Multispecialist"),
                               Row(
                                 children: [
                                   Icon(Icons.star),
                                   Icon(Icons.star),
                                   Icon(Icons.star),
                                 ],
                               )
                             ],
                           ),
                           SizedBox(width:30,),
                           Icon(Icons.arrow_forward,size:40,)
                         ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(20),


              child: InkWell(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalInfo(image: "assets/sasun.jpg",logo: "assets/sasunlogo.jpg",doctorName: "Sasun",doctorId: "asd",specialization: "Multispeciality",),));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width:MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: BoxDecoration(

                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Image.asset("assets/derma.jpg"),
                          ),
                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sasun Government"),
                              Text("Pune"),
                              Text("Multispecialist"),
                              Row(
                                children: [
                                  Icon(Icons.star),
                                  Icon(Icons.star),
                                  Icon(Icons.star),
                                ],
                              )
                            ],
                          ),
                          SizedBox(width:30,),
                          Icon(Icons.arrow_forward,size:40,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Reports",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 23
              ),),
            ),
            SizedBox(height: 20,),
          ],
        ),
      )),
    );
  }
  Widget servicesTile(imagePath,info){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AppointementLandingPage(),));
      },
      child: Container(
        
        width: 100,
        height:100,
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.grey,width: 0.5
          // ),
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("$imagePath"),
                backgroundColor: Colors.grey.shade100,
                foregroundColor: Colors.grey.shade100,
              ),
              SizedBox(height: 10,),
              Text("$info",style: TextStyle(
      
                fontWeight: FontWeight.bold,fontSize: 14
              ),),
      
            ],
          ),
        ),
      ),
    );
  }
}
