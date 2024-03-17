import 'package:flutter/material.dart';

import '../Dashboard/dashboard.dart';


class ThanksForRegistering extends StatefulWidget {
  const ThanksForRegistering({super.key});

  @override
  State<ThanksForRegistering> createState() => _ThanksForRegisteringState();
}

class _ThanksForRegisteringState extends State<ThanksForRegistering> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(
      seconds:3,
    )).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text("Logged In Successfully")));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("Thanks for Registering !",style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 25
            ),),
            SizedBox(height: 20,),
            Image.asset("assets/successgif.gif"),


          ],
        ),
      ),
    );
  }
}
