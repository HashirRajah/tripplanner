import 'package:flutter/material.dart';
import 'package:tripplanner/models/city_model.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/destination_card.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/more_button.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class PopularSection extends StatefulWidget {
  const PopularSection({super.key});

  @override
  State<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  final String title = 'Popular destinations';
  final LocalService localService = LocalService();
  List<CityModel> destinations = [];
  //
  @override
  void initState() {
    super.initState();
    //
    getDestinations();
  }

  //
  Future<void> getDestinations() async {
    dynamic result = await localService.getPopularDestination(30);
    //
    if (result != null) {
      setState(() {
        destinations = result;
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
            height: (spacing_8 * 35),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return DestinationCard(
                  destination: destinations[index],
                );
              },
              itemCount: destinations.length,
            ),
          ),
        ],
      ),
    );
  }
}
