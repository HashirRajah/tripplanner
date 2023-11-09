import 'package:flutter/material.dart';
import 'package:tripplanner/models/osm_poi_model.dart';
import 'package:tripplanner/screens/maps/simple_map.dart';
import 'package:tripplanner/screens/maps/simple_map_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class OSMCard extends StatefulWidget {
  final OSMPOIModel place;
  //
  const OSMCard({
    super.key,
    required this.place,
  });

  @override
  State<OSMCard> createState() => _OSMCardState();
}

class _OSMCardState extends State<OSMCard> {
  //
  List<Widget> buildBody() {
    List<Widget> body = [];
    //
    body.add(Container(
      margin: const EdgeInsets.only(bottom: spacing_16),
      child: Text(
        widget.place.type.toUpperCase(),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    ));
    //
    List<Widget> additionalWidgets = [];
    for (var item in widget.place.tags.entries) {
      if (item.key == 'name') {
        additionalWidgets.add(Container(
          margin: const EdgeInsets.only(bottom: spacing_16),
          child: Text(
            item.value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ));
      } else if (item.key == 'opening_hours') {
        additionalWidgets.add(Container(
          margin: const EdgeInsets.only(bottom: spacing_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Opening Hours:',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              addVerticalSpace(spacing_8),
              Text(
                item.value.replaceAll(';', ''),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
      } else if (item.key == 'phone') {
        additionalWidgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone:',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            addVerticalSpace(spacing_8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.value,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: green_10,
                  child: IconButton(
                    onPressed: () async {
                      final Uri numberUrl = Uri(
                        scheme: 'tel',
                        path: item.value,
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
            ),
          ],
        ));
      } else if (item.key == 'website') {
        additionalWidgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Website:',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            addVerticalSpace(spacing_8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.value,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: green_10,
                  child: IconButton(
                    onPressed: () async {
                      final Uri link = Uri.parse(item.value);
                      //
                      if (await canLaunchUrl(link)) {
                        //
                        launchUrl(link);
                      }
                    },
                    icon: Icon(
                      Icons.link,
                      color: white_60,
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
      }
    }
    //
    body.add(Container(
      padding: const EdgeInsets.symmetric(vertical: spacing_8),
      height: (spacing_8 * 24),
      child: ListView(
        children: additionalWidgets,
      ),
    ));
    //

    //
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(spacing_24),
          margin:
              const EdgeInsets.fromLTRB(0.0, spacing_8, spacing_16, spacing_8),
          width: (spacing_8 * 38),
          decoration: BoxDecoration(
            color: tripCardColor,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildBody(),
          ),
        ),
        Positioned(
          bottom: spacing_16,
          right: spacing_24,
          child: CircleAvatar(
            backgroundColor: green_10,
            foregroundColor: white_60,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SimpleMapScreen(
                        place: widget.place.position,
                      ),
                    ));
              },
              icon: const Icon(Icons.map_outlined),
            ),
          ),
        )
      ],
    );
  }
}
