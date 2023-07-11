import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/poi_details_app_bar.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class POIDetailsScreen extends StatefulWidget {
  final POIModel poi;
  final bool liked;
  final Function updateLikes;
  //
  const POIDetailsScreen({
    super.key,
    required this.poi,
    required this.liked,
    required this.updateLikes,
  });

  @override
  State<POIDetailsScreen> createState() => _POIDetailsScreenState();
}

class _POIDetailsScreenState extends State<POIDetailsScreen> {
  String imageLink =
      'https://images.unsplash.com/photo-1465447142348-e9952c393450?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80';
  //
  late final DateTime startDate;
  late final DateTime endDate;
  bool loadingDates = true;
  late final TripsCRUD tripsCRUD;
  //
  @override
  void initState() {
    super.initState();
    //
    final String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    //
    tripsCRUD = TripsCRUD(tripId: tripId);
    //
    getDates();
  }

  //
  //
  Future<void> getDates() async {
    //
    dynamic result = await tripsCRUD.getStartAndEndDates();
    //
    startDate = DateTime.parse(result['start']);
    endDate = DateTime.parse(result['end']);
    DateTime today = DateTime.now();
    //
    //daysCount = endDate.difference(startDate).inDays + 1;
    //
    loadingDates = false;
    //
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // Widget buildBody() {}

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          POIDetailSliverAppBar(
            imageLink: widget.poi.image,
            lat: widget.poi.lat,
            lng: widget.poi.lng,
            liked: widget.liked,
            updateLikes: widget.updateLikes,
            id: widget.poi.id,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(spacing_16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.amber,
                        ),
                        child: Text(
                          'Rating ${widget.poi.rating.toString()} / 5',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: green_10,
                          ),
                        ),
                      ),
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
                  addVerticalSpace(spacing_24),
                  ElevatedButtonWrapper(
                    childWidget: ElevatedButton.icon(
                      onPressed: () async {
                        if (!loadingDates) {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: startDate, //get today's date
                            firstDate:
                                startDate, //DateTime.now() - not to allow to choose before today.
                            lastDate: endDate,
                          );
                        }
                      },
                      icon: const Icon(Icons.add_location),
                      label: const Text('Add Visit'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
