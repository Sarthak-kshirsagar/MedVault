import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCallScreen extends StatefulWidget {
  @override
  _ApiCallScreenState createState() => _ApiCallScreenState();
}

class _ApiCallScreenState extends State<ApiCallScreen> {
  String _apiResponse = '';

  Future<void> sendObjectToAPI() async {
    final String apiUrl = 'https://django-render-ml-deploy.onrender.com/api/vitamin/';  // Replace with your actual API endpoint

    // Define the object
    Map<String, dynamic> requestBody = {
      "Age": 20,
      "Weight": 70,
      "BMI" : 20,
      "Exercise": 1,
    };

    // Convert the object to JSON
    String requestBodyJson = jsonEncode(requestBody);

    try {
      // Send POST request to the API endpoint with JSON body
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBodyJson,
      );

      // Check the response status
      if (response.statusCode == 200) {
        setState(() {
          _apiResponse = response.body;
        });
      } else {
        setState(() {
          _apiResponse = 'API request failed with status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _apiResponse = 'Error sending API request: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Call Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: sendObjectToAPI,
              child: Text('Send API Request'),
            ),
            SizedBox(height: 20),
            Text(
              'API Response:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_apiResponse),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
