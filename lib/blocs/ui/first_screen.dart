import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);

  final String xData;
  final num yData;
  String? text;
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<Color> gradientColors = [
    Colors.green,
    Colors.yellow,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Colors.green,
      Colors.yellow,
    ];

    bool showAvg = false;

    List<_SalesData> data = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40),
      _SalesData('Jun', 31),
      _SalesData('Jul', 25),
      _SalesData('Aug', 35),
      _SalesData('Sept', 55),
      _SalesData('Oct', 48),
      _SalesData('Nov', 42),
      _SalesData('Dec', 60),
    ];
    List<_PieData> pie_data = [
      _PieData('Jan', 12, 'Food'),
      _PieData('Feb', 6, 'test'),
      _PieData('Mar', 8, 'test'),
      _PieData('Apr', 10, 'test'),
      _PieData('May', 8, 'test'),
      _PieData('Jun', 10, 'test'),
      _PieData('Jul', 14, 'test'),
      _PieData('Aug', 16, 'test'),
      _PieData('Sept', 12, 'test'),
      _PieData('Oct', 5, 'test'),
      _PieData('Nov', 14, 'test'),
      _PieData('Dec', 15, 'test'),
    ];
    final List<double> sparkBarData = [5, 10, 8, 15, 20, 18, 25, 30, 22,27,31,14];
    const cutOffYValue = 5.0;
    return MaterialApp(
      title: 'Expense Tracker Sms ',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      SfCartesianChart(
                          primaryXAxis: const CategoryAxis(),
                          title: const ChartTitle(text: 'Cartesian Chart'),
                          legend: const Legend(isVisible: true),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CartesianSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                                dataSource: data,
                                xValueMapper: (_SalesData sales, _) => sales.year,
                                yValueMapper: (_SalesData sales, _) => sales.sales,
                                name: 'Sales',
                                dataLabelSettings:
                                const DataLabelSettings(isVisible: true))
                          ]),
                      SfCircularChart(
                          title: const ChartTitle(text: 'Circular Chart'),
                          legend: const Legend(isVisible: true),
                          series: <PieSeries<_PieData, String>>[
                            PieSeries<_PieData, String>(
                                explode: true,
                                explodeIndex: 0,
                                dataSource: pie_data,
                                xValueMapper: (_PieData data, _) => data.xData,
                                yValueMapper: (_PieData data, _) => data.yData,
                                dataLabelMapper: (_PieData data, _) => data.text,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                          ]),
                      Column(
                        children: [
                          const Text('Bar Chart', style: TextStyle(fontSize: 16)),
                          SfSparkBarChart(
                            axisLineWidth: 0,
                            data: sparkBarData,
                            trackball: const SparkChartTrackball(
                              activationMode: SparkChartActivationMode.tap,
                            ),
                            labelDisplayMode: SparkChartLabelDisplayMode.all,
                            color: Colors.blue,
                            axisLineColor: Colors.grey,
                            highPointColor: Colors.green,
                            lowPointColor: Colors.red,
                            negativePointColor: Colors.orange,
                            firstPointColor: Colors.purple,
                            lastPointColor: Colors.yellow,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 350,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                            sections: [
                              PieChartSectionData(
                                value: 35,
                                color: Colors.purple,
                                radius: 100,
                                title: '35%',
                                titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                              PieChartSectionData(
                                value: 40,
                                color: Colors.amber,
                                radius: 100,
                                title: '40%',
                                titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                              PieChartSectionData(
                                value: 55,
                                color: Colors.green,
                                radius: 100,
                                title: '55%',
                                titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                              PieChartSectionData(
                                value: 70,
                                color: Colors.orange,
                                radius: 100,
                                title: '70%',
                                titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        child:
                        BarChart(BarChartData(
                            borderData: FlBorderData(
                                border: const Border(
                                  top: BorderSide.none,
                                  right: BorderSide.none,
                                  left: BorderSide(width: 1),
                                  bottom: BorderSide(width: 1),
                                )),
                            groupsSpace: 10,
                            barGroups: [
                              BarChartGroupData(x: 1, barRods: [
                                BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
                              ]),
                              BarChartGroupData(x: 2, barRods: [
                                BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
                              ]),
                              BarChartGroupData(x: 3, barRods: [
                                BarChartRodData(fromY: 0, toY: 15, width: 15, color: Colors.amber),
                              ]),
                              BarChartGroupData(x: 4, barRods: [
                                BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
                              ]),
                              BarChartGroupData(x: 5, barRods: [
                                BarChartRodData(fromY: 0, toY: 11, width: 15, color: Colors.amber),
                              ]),
                              BarChartGroupData(x: 6, barRods: [
                                BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
                              ]),
                              BarChartGroupData(x: 7, barRods: [
                                BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
                              ]),
                              BarChartGroupData(x: 8, barRods: [
                                BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
                              ]),
                            ])),

                      ),
                      SizedBox(
                        height: 250,
                        child:
                        AspectRatio(
                          aspectRatio: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 28,
                              top: 22,
                              bottom: 12,
                            ),
                            child: LineChart(
                              LineChartData(
                                lineTouchData: const LineTouchData(enabled: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: const [
                                      FlSpot(0, 2),
                                      FlSpot(1, 6),
                                      FlSpot(2, 2),
                                      FlSpot(3, 6),
                                      FlSpot(4, 4),
                                      FlSpot(5, 5),
                                      FlSpot(6, 4),
                                      FlSpot(7, 6),
                                      FlSpot(8, 4),
                                      FlSpot(9, 6),
                                      FlSpot(10, 6),
                                      FlSpot(11, 7),
                                    ],
                                    isCurved: true,
                                    barWidth: 3,
                                    color: Colors.grey,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Colors.green,
                                      cutOffY: cutOffYValue,
                                      applyCutOffY: true,
                                    ),
                                    aboveBarData: BarAreaData(
                                      show: true,
                                      color: Colors.red,
                                      cutOffY: cutOffYValue,
                                      applyCutOffY: true,
                                    ),
                                    dotData: const FlDotData(
                                      show: false,
                                    ),
                                  ),
                                ],
                                minY: 0,
                                titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  bottomTitles: AxisTitles(
                                    axisNameWidget: Text(
                                      '2024',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 18,
                                      interval: 1,
                                      getTitlesWidget: bottomTitleChartWidgets,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    axisNameSize: 20,
                                    axisNameWidget: const Text(
                                      'Value',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      reservedSize: 40,
                                      getTitlesWidget: leftTitleChartsWidgets,
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 2,
                                  checkToShowHorizontalLine: (double value) {
                                    return value == 1 ||value == 2 || value == 6 || value == 4 || value == 5;
                                  },
                                ),
                              ),
                            ),
                          ),
                        )

                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget bottomTitleChartWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget leftTitleChartsWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '10K';
        break;
      case 1:
        text = '20K';
        break;
      case 2:
        text = '30K';
        break;
      case 3:
        text = '40K';
        break;
      case 4:
        text = '50K';
        break;
      case 5:
        text = '60K';
        break;
      case 6:
        text = '70k';
        break;
      case 7:
        text = '80k';
        break;


      default:
        return Container();
    }


    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }
}
