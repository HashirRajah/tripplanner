import 'package:flutter/material.dart';
import 'package:tripplanner/models/score_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class Scores extends StatefulWidget {
  final List<ScoreModel> scores;
  //
  const Scores({
    super.key,
    required this.scores,
  });

  @override
  State<Scores> createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  //
  List<Widget> getScoreBars() {
    List<Widget> scoreBars = [];
    for (ScoreModel score in widget.scores) {
      double percentage = ((score.score / 10));
      scoreBars.add(Container(
        margin: const EdgeInsets.only(bottom: spacing_8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              score.category,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            addVerticalSpace(spacing_8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (spacing_8 * 30),
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 10.0,
                    percent: percentage,
                    progressColor: score.color,
                    backgroundColor: score.color.withOpacity(0.3),
                  ),
                ),
                addHorizontalSpace(spacing_8),
                Text(
                  '${score.score.ceil()} / 10',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ));
    }
    return scoreBars;
  }

  //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: getScoreBars(),
    );
  }
}
