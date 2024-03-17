import 'package:flutter/material.dart';



class DietScreen extends StatefulWidget {
  const DietScreen();
  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  String selectedDisease = '';
  List<String> suggestedFruits = [];
  List<String> suggestedVegetables = [];
  List<String> suggestedDietaryChanges = [];

  void suggestDiet() {
    // Logic to suggest diet based on selected disease
    switch (selectedDisease) {
      case 'Diabetes':
        setState(() {
          suggestedFruits = ['Apples', 'Berries', 'Citrus fruits'];
          suggestedVegetables = ['Leafy greens', 'Broccoli', 'Carrots'];
          suggestedDietaryChanges = [
            'Limit sugar intake',
            'Control carbohydrate consumption'
          ];
        });
        break;
      case 'Hypertension':
        setState(() {
          suggestedFruits = ['Bananas', 'Oranges', 'Watermelon'];
          suggestedVegetables = ['Spinach', 'Tomatoes', 'Avocado'];
          suggestedDietaryChanges = [
            'Reduce salt intake',
            'Eat more potassium-rich foods'
          ];
        });
        break;
      case 'High Cholesterol':
        setState(() {
          suggestedFruits = ['Avocado', 'Berries', 'Citrus fruits'];
          suggestedVegetables = ['Spinach', 'Broccoli', 'Garlic'];
          suggestedDietaryChanges = [
            'Limit saturated fats',
            'Increase intake of healthy fats like omega-3'
          ];
        });
        break;
      case 'Anemia':
        setState(() {
          suggestedFruits = ['Spinach', 'Beetroot', 'Apples'];
          suggestedVegetables = ['Kale', 'Lentils', 'Beans'];
          suggestedDietaryChanges = [
            'Increase iron-rich foods consumption',
            'Eat vitamin C rich foods to enhance iron absorption'
          ];
        });
        break;
    // Add more cases for other diseases
      default:
        setState(() {
          suggestedFruits = [];
          suggestedVegetables = [];
          suggestedDietaryChanges = [];
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dietary Suggestions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: selectedDisease.isNotEmpty ? selectedDisease : null,
              hint: Text('Select Disease'),
              items: <String>[
                '',
                'Diabetes',
                'Hypertension',
                'High Cholesterol',
                'Anemia',
                // Add more diseases as needed
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.isNotEmpty ? value : 'Select Disease'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDisease = value!;
                  suggestDiet();
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Suggested Fruits:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: suggestedFruits.map((fruit) {
                return Text('- $fruit');
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Suggested Vegetables:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: suggestedVegetables.map((vegetable) {
                return Text('- $vegetable');
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Dietary Changes:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: suggestedDietaryChanges.map((change) {
                return Text('- $change');
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}