import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/models/find_card_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class FindCard extends StatelessWidget {
  //
  final FindCardModel findCardModel;
  //
  const FindCard({
    super.key,
    required this.findCardModel,
  });

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      margin: const EdgeInsets.only(bottom: spacing_16),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            padding: const EdgeInsets.all(spacing_16),
            height: (spacing_8 * 22),
            width: double.infinity,
            decoration: BoxDecoration(
              color: findCardModel.cardColor,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  findCardModel.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: green_10,
                      ),
                ),
                addVerticalSpace(spacing_8),
                Text(
                  'Find ${findCardModel.title}',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: green_10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Hero(
            tag: 'find',
            child: SvgPicture.asset(
              findCardModel.svgFilePath,
              height: (spacing_8 * 10),
            ),
          ),
          Positioned(
            left: spacing_16,
            bottom: spacing_8,
            child: CircleAvatar(
              backgroundColor: findCardModel.buttonColor,
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () {
                  findCardModel.onPressed(context);
                },
                icon: const Icon(Icons.arrow_forward_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
