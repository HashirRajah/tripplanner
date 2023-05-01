import 'package:flutter/material.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trip_card.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trips_list.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trips_sliver_app_bar.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TripsListScreen extends StatefulWidget {
  const TripsListScreen({super.key});

  @override
  State<TripsListScreen> createState() => _TripsListScreenState();
}

class _TripsListScreenState extends State<TripsListScreen> {
  final List<String> list = [
    'Paris trip',
    'Mumbai',
    'Mexico',
    'India',
    'New delhi',
    'England',
    'Australia',
  ];
  late List<String> filteredList;
  final TextEditingController controller = TextEditingController();
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    filteredList = list;
  }

  //
  void filterList(String query) {
    if (query.isEmpty) {
      filteredList = list;
    } else {
      filteredList = list.where((element) {
        return element.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    //
    setState(() {});
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return CustomScrollView(
      slivers: [
        TripsSliverAppBar(
          search: filterList,
          controller: controller,
        ),
        TripsList(
          list: filteredList,
        ),
      ],
    );
  }
}
