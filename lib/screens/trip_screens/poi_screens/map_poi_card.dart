import 'package:flutter/material.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/map_simple_poi_details_screen.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/simple_poi_details_screen.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class MapPOICard extends StatefulWidget {
  final POIModel poi;
  final Function dismiss;
  final String userId;
  final bool liked;
  final Function updateLikes;
  //
  const MapPOICard({
    super.key,
    required this.poi,
    required this.dismiss,
    required this.userId,
    required this.liked,
    required this.updateLikes,
  });

  @override
  State<MapPOICard> createState() => _MapPOICardState();
}

class _MapPOICardState extends State<MapPOICard> {
  final LocalService localService = LocalService();
  late bool like;
  late UsersCRUD usersCRUD;
  String imageLink =
      'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1121&q=80';
  //
  @override
  void initState() {
    super.initState();
    //
    like = widget.liked;
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
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        SizedBox(
          height: (spacing_8 * 20),
          child: Card(
            elevation: 3.0,
            color: tripCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: SizedBox(
              width: (spacing_8 * 45),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    ),
                    child: Image.network(
                      widget.poi.image,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(imageLink);
                      },
                      fit: BoxFit.cover,
                      width: (spacing_8 * 16),
                      height: (spacing_8 * 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(spacing_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: (spacing_8 * 22),
                          child: Text(
                            widget.poi.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        addVerticalSpace(spacing_8),
                        SizedBox(
                          width: (spacing_8 * 22),
                          child: Text(
                            widget.poi.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        addVerticalSpace(spacing_8),
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
        ),
        Positioned(
          bottom: spacing_16,
          right: spacing_16,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: white_60,
            child: IconButton(
              onPressed: () async {
                //
                await localService.addPOIView(widget.userId, widget.poi.id);
                //
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (newContext) => MapSimplePOIDetailsScreen(
                        poi: widget.poi,
                        liked: like,
                        updateLikes: widget.updateLikes,
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.dismiss();
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
