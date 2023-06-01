import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class Badge extends StatelessWidget {
  final double size;
  final IconData iconData;
  final Color borderColor;
  //
  const Badge({
    super.key,
    required this.size,
    required this.iconData,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Icon(
          iconData,
          color: green_10,
        ),
      ),
    );
  }
}
