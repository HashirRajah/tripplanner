import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/map_poi_details_app_bar.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/poi_details_app_bar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class MapSimplePOIDetailsScreen extends StatefulWidget {
  final POIModel poi;
  final bool liked;
  final Function updateLikes;
  //
  const MapSimplePOIDetailsScreen({
    super.key,
    required this.poi,
    required this.liked,
    required this.updateLikes,
  });

  @override
  State<MapSimplePOIDetailsScreen> createState() =>
      _MapSimplePOIDetailsScreenState();
}

class _MapSimplePOIDetailsScreenState extends State<MapSimplePOIDetailsScreen> {
  String imageLink =
      'https://images.unsplash.com/photo-1465447142348-e9952c393450?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80';
  //

  late final String userId;
  bool processing = false;

  //
  @override
  void initState() {
    super.initState();
    userId = Provider.of<User?>(context, listen: false)!.uid;
  }

  //
  //

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  @override
  void dispose() {
    //
    //
    super.dispose();
  }

  //

  // Widget buildBody() {}

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MapPOIDetailSliverAppBar(
            imageLink: widget.poi.image,
            liked: widget.liked,
            id: widget.poi.id,
            updateLikes: widget.updateLikes,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(spacing_24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.poi.name,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          letterSpacing: 3.0,
                          fontWeight: FontWeight.bold,
                        ),
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
                  addVerticalSpace(spacing_24),
                  Container(
                    padding: const EdgeInsets.all(spacing_16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: tripCardColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.route,
                          color: green_30,
                        ),
                        addHorizontalSpace(spacing_16),
                        Text(
                          widget.poi.distance,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(spacing_24),
                  Text(
                    widget.poi.description,
                    style: const TextStyle(letterSpacing: 1.5, height: 1.5),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
