import 'package:flutter/material.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/destination_detail_screen.dart';
import 'package:tripplanner/services/pixaby_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class POICard extends StatefulWidget {
  final POIModel poi;
  //
  const POICard({
    super.key,
    required this.poi,
  });

  @override
  State<POICard> createState() => _POICardState();
}

class _POICardState extends State<POICard> {
  String imageLink =
      'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1121&q=80';
  //
  @override
  void initState() {
    super.initState();
    //
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: spacing_8),
      child: Stack(
        children: <Widget>[
          Card(
            elevation: 3.0,
            color: tripCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: SizedBox(
              width: (spacing_8 * 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    child: Image.network(
                      widget.poi.image,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(imageLink);
                      },
                      fit: BoxFit.cover,
                      width: (spacing_8 * 35),
                      height: (spacing_8 * 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(spacing_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.poi.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(spacing_8),
                        Text(
                          widget.poi.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(spacing_16),
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              color: gold,
                            ),
                            addHorizontalSpace(spacing_8),
                            Text(widget.poi.views.toString()),
                            addHorizontalSpace(spacing_16),
                            Icon(
                              Icons.favorite,
                              color: errorColor,
                            ),
                            addHorizontalSpace(spacing_8),
                            Text(widget.poi.likes.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: spacing_16,
            right: spacing_16,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: white_60,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_location),
                  ),
                ),
                addHorizontalSpace(spacing_8),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: white_60,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Placeholder();
                        },
                      ));
                    },
                    icon: const Icon(Icons.arrow_forward_outlined),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: spacing_16,
            right: spacing_16,
            child: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.4),
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
            ),
          ),
          Positioned(
            top: spacing_16,
            left: spacing_16,
            child: Container(
              padding: const EdgeInsets.all(spacing_8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                '${widget.poi.rating.toString()} / 5',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: white_60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
