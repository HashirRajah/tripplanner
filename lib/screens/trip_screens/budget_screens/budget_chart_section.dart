import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/badge.dart';

PieChartSectionData chartDataSection(
    double value, Color color, Color borderColor, IconData icon) {
  //
  const double radius = (spacing_8 * 17);
  //
  return PieChartSectionData(
    color: color,
    title: '${value.toStringAsFixed(1)}%',
    value: value,
    radius: radius,
    titleStyle: chartTextStyle,
    badgeWidget: Badge(
      size: (spacing_8 * 6),
      borderColor: borderColor,
      iconData: icon,
    ),
    badgePositionPercentageOffset: .98,
  );
}
