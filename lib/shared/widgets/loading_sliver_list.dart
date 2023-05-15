import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class LoadingSliverList extends StatelessWidget {
  const LoadingSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          children: <Widget>[
            addVerticalSpace(spacing_64),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
