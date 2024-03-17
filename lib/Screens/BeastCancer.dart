import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BreastCancerAPIScreen extends StatefulWidget {
  @override
  _BreastCancerAPIScreenState createState() => _BreastCancerAPIScreenState();
}

class _BreastCancerAPIScreenState extends State<BreastCancerAPIScreen> {
  String _apiResponse = '';

  Future<void> sendRequestToBreastCancerAPI() async {
    final String apiUrl = 'https://django-render-ml-deploy.onrender.com/api/breastCancer/';

    // Define the input data as a JSON object
    Map<String, dynamic> requestBody = {
      "radius_mean": 12,
      "texture_mean": 9,
      "perimeter_mean": 11,
      "area_mean": 8,
    };

    // Encode the JSON object to a URL-safe string
    String encodedRequestBody = Uri.encodeQueryComponent(jsonEncode(requestBody));

    try {
      // Construct the API URL with the encoded JSON data in the query string
      String requestUrl = '$apiUrl?data=$encodedRequestBody';

      // Send GET request to the API endpoint with JSON data in the URL
      http.Response response = await http.get(Uri.parse(requestUrl));

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
        title: Text('Breast Cancer API Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: sendRequestToBreastCancerAPI,
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
