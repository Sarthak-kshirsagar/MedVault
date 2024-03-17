import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(DateTime(2010), 10),
      SalesData(DateTime(2011), 15),
      SalesData(DateTime(2012), 20),
      SalesData(DateTime(2013), 25),
      SalesData(DateTime(2014), 30),
      SalesData(DateTime(2015), 35),
      SalesData(DateTime(2016), 36),
      SalesData(DateTime(2017), 37),
      SalesData(DateTime(2018), 38),
      SalesData(DateTime(2019), 39),
      SalesData(DateTime(2020), 40),
      SalesData(DateTime(2021), 40),
      SalesData(DateTime(2022), 40),
      SalesData(DateTime(2023), 40),
      SalesData(DateTime(2024), 40),
    ];

    // Calculate change in values
    final List<ChangeData> changeData = [];
    for (int i = 1; i < chartData.length; i++) {
      double change = chartData[i].sales - chartData[i - 1].sales;
      changeData.add(ChangeData(chartData[i].year, change));
    }

    return Scaffold(

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Graph of Change in Eyesight',style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize:15
              ),),
            ),
            SizedBox(
              height: 300, // Chart chi height
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}',
                  title: AxisTitle(text: 'Change in EyeSight'),
                ),
                series: <CartesianSeries>[
                  SplineSeries<ChangeData, DateTime>(
                    dataSource: changeData,
                    xValueMapper: (ChangeData data, _) => data.year,
                    yValueMapper: (ChangeData data, _) => data.change,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class ChangeData {
  ChangeData(this.year, this.change);
  final DateTime year;
  final double change;
}
