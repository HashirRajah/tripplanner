import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/services/country_flag_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class TravelInfoAppBar extends StatelessWidget {
  //
  final List<DestinationModel> destinations;
  final String title = 'Travel Info';

  //
  const TravelInfoAppBar({
    super.key,
    required this.destinations,
  });

  Widget getImage(String code) {
    try {
      if (code == 'NONE') {
        return const Icon(Icons.flag);
      } else {
        return Image.network(
          CountryFlagService(country: code).getUrl(64),
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.flag);
          },
        );
      }
    } catch (e) {
      return const Icon(Icons.flag);
    }
  }

  //
  List<Widget> getTabs() {
    return destinations
        .map((DestinationModel dest) => Tab(
              text: dest.description,
              icon: getImage(dest.countryCode),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: darkOverlayStyle,
      title: Text(
        title,
        style: TextStyle(color: green_10, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: green_10,
        ),
      ),
      bottom: TabBar(
        indicatorColor: green_10,
        labelColor: green_10,
        indicatorWeight: 3.0,
        tabs: getTabs(),
      ),
    );
  }
}
