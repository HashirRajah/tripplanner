import 'package:flutter/material.dart';
import 'package:tripplanner/models/find_nearest_model.dart';
import 'package:tripplanner/models/simple_news_model.dart';
import 'package:tripplanner/screens/maps/nearest_places_map_screen.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/news_card.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class FindNearestSection extends StatefulWidget {
  //
  const FindNearestSection({
    super.key,
  });

  @override
  State<FindNearestSection> createState() => _FindNearestSectionState();
}

class _FindNearestSectionState extends State<FindNearestSection> {
  final String title = 'Find Nearest';
  final List<FindNearestModel> findNearest = [
    FindNearestModel(
      title: 'Police Stations',
      iconData: Icons.local_police,
    ),
    FindNearestModel(
      title: 'Hospitals',
      iconData: Icons.local_hospital,
    ),
    FindNearestModel(
      title: 'Fire Stations',
      iconData: Icons.local_fire_department,
    ),
    FindNearestModel(
      title: 'Pharmacies',
      iconData: Icons.local_pharmacy,
    ),
    FindNearestModel(
      title: 'Gas Stations',
      iconData: Icons.local_gas_station,
    ),
  ];
  //
  @override
  void initState() {
    super.initState();
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
    //
    return Container(
      margin: const EdgeInsets.only(bottom: spacing_24),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: green_10),
              ),
            ],
          ),
          addVerticalSpace(spacing_8),
          SizedBox(
            height: (spacing_8 * 7),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return NearestPlacesMap(
                          title: findNearest[index].title,
                        );
                      },
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(spacing_16),
                    margin: const EdgeInsets.only(left: spacing_16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: tripCardColor,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          findNearest[index].iconData,
                        ),
                        addHorizontalSpace(spacing_8),
                        Text(
                          findNearest[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: findNearest.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
