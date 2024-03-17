import 'package:flutter/material.dart';

import 'BeastCancer.dart';
import 'VitaminInsights.dart';
import 'ai.dart';
class AiFeatures extends StatefulWidget {
  const AiFeatures({super.key});

  @override
  State<AiFeatures> createState() => _AiFeaturesState();
}

class _AiFeaturesState extends State<AiFeatures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Ai Features",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 25
                ),),
              ),
            ),
            Wrap(
              runSpacing: 20,

              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DietScreen(),));
                  },
                  child: Container(
                    width: 300,
                    height:80,
                    child: Center(child: Text("Diertery Suggestions",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 16
                    ),)),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,width: 0.5,

                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BreastCancerAPIScreen(),));
                  },
                  child: Container(
                    width: 300,
                    height:80,
                    child: Center(child: Text("Breast Cancer Detection",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 16
                    ),)),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,width: 0.5,

                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DietScreen(),));
                  },
                  child: Container(
                    width: 300,
                    height:80,
                    child: Center(child: Text("Medical Report Summarizer",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 16
                    ),)),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,width: 0.5,

                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ApiCallScreen(),));
                  },
                  child: Container(
                    width: 300,
                    height:80,
                    child: Center(child: Text("Vitamin Deficiency Detector",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 16
                    ),)),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,width: 0.5,

                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),);
  }
}
