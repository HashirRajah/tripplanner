import 'package:flutter/material.dart';
import 'package:tripplanner/models/place_card_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceCard extends StatelessWidget {
  //
  final Function dismiss;
  final PlaceCardModel place;
  //
  const PlaceCard({
    super.key,
    required this.place,
    required this.dismiss,
  });

  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          padding: const EdgeInsets.all(spacing_16),
          width: getXPercentScreenWidth(90, screenWidth),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: tripCardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              addVerticalSpace(spacing_16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    place.contact,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                  ),
                  CircleAvatar(
                    backgroundColor: green_10,
                    child: IconButton(
                      onPressed: () async {
                        final Uri numberUrl = Uri(
                          scheme: 'tel',
                          path: place.contact,
                        );
                        //
                        if (await canLaunchUrl(numberUrl)) {
                          //
                          launchUrl(numberUrl);
                        }
                      },
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.greenAccent,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            dismiss();
          },
          icon: Icon(
            Icons.close,
            color: errorColor,
          ),
        ),
      ],
    );
  }
}
