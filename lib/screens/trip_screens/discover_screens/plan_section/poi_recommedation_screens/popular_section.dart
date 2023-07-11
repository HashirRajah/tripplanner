import 'package:flutter/material.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/poi_card.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class PopularPOISection extends StatefulWidget {
  final String destination;
  //
  const PopularPOISection({
    super.key,
    required this.destination,
  });

  @override
  State<PopularPOISection> createState() => _PopularPOISectionState();
}

class _PopularPOISectionState extends State<PopularPOISection> {
  final String title = 'Popular';
  final LocalService localService = LocalService();
  List<POIModel> pois = [];
  late String cachedDestination;
  //
  @override
  void initState() {
    super.initState();
    //
    cachedDestination = widget.destination;
    //
    getPOIs();
  }

  //
  Future<void> getPOIs() async {
    dynamic result = await localService.getPopularPOIs(
      10,
      widget.destination.toLowerCase(),
    );
    //
    if (result != null) {
      setState(() {
        pois = result;
      });
    }
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    if (cachedDestination != widget.destination) {
      getPOIs();
      cachedDestination = widget.destination;
    }
    //
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: green_10,
                ),
          ),
          addVerticalSpace(spacing_16),
          SizedBox(
            height: (spacing_8 * 40),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return POICard(
                  type: 'popular',
                  poi: pois[index],
                );
              },
              itemCount: pois.length,
            ),
          ),
        ],
      ),
    );
  }
}
