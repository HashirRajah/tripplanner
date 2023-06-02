import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/badge.dart';

class BudgetChart extends StatefulWidget {
  const BudgetChart({super.key});

  @override
  State<BudgetChart> createState() => _BudgetChartState();
}

class _BudgetChartState extends State<BudgetChart> {
  //
  int touchedIndex = 0;
  //
  List<PieChartSectionData> getSections() {
    return List.generate(5, (i) {
      const double fontSize = 24.0;
      const double radius = 140.0;
      const double widgetSize = 55.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: flightsCardColor,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: Badge(
              iconData: Icons.airplane_ticket,
              size: widgetSize,
              borderColor: paletteOrange,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: hotelsCardColor,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: Badge(
              iconData: FontAwesomeIcons.hotel,
              size: widgetSize,
              borderColor: green_10,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: carRentalsCardColor,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: Badge(
              iconData: FontAwesomeIcons.car,
              size: widgetSize,
              borderColor: alternateGreen,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: airportTransfersCardColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: Badge(
              iconData: Icons.local_activity,
              size: widgetSize,
              borderColor: errorColor,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: Colors.purple[100],
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: Badge(
              iconData: Icons.menu,
              size: widgetSize,
              borderColor: Colors.purple,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Padding(
      padding: const EdgeInsets.all(spacing_16),
      child: Container(
        height: getXPercentScreenHeight(40, screenHeight),
        decoration: BoxDecoration(
          color: green_10,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: PieChart(
            PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              centerSpaceRadius: 0.0,
              sectionsSpace: 0.0,
              sections: getSections(),
            ),
          ),
        ),
      ),
    );
  }
}
