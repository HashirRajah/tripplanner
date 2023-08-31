import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/models/visit_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/poi_details_app_bar.dart';
import 'package:tripplanner/screens/trip_screens/schedules_screens/explore_sections/nearby_places_section.dart';
import 'package:tripplanner/screens/trip_screens/schedules_screens/explore_sections/plan_recommendation_section.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/firestore_services/visit_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
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

class _POIDetailsScreenState extends State<POIDetailsScreen>
    with SingleTickerProviderStateMixin {
  String imageLink =
      'https://images.unsplash.com/photo-1465447142348-e9952c393450?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80';
  //
  late final DateTime startDate;
  late final DateTime endDate;
  bool loadingDates = true;
  late final TripsCRUD tripsCRUD;
  late final VisitsCRUD visitsCRUD;
  late final String userId;
  final String successMessage = 'Visit Added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  bool processing = false;
  bool initializedDates = false;
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    super.initState();
    //
    final String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    tripsCRUD = TripsCRUD(tripId: tripId);
    visitsCRUD = VisitsCRUD(tripId: tripId, userId: userId);
    //
    getDates();
    //
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
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
    initializedDates = true;
    //
    setState(() {});
  }

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
    controller.dispose();
    //
    super.dispose();
  }

  //
  Future<void> addVisit(DateTime date, VisitModel visit) async {
    //
    setState(() {
      processing = true;
    });
    //
    dynamic result = await visitsCRUD.addVisit(date, visit);
    //
    setState(() {
      processing = false;
    });
    //
    if (result == null) {
      if (context.mounted) {
        messageDialog(
            context, successMessage, successLottieFilePath, controller, false);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar(context, 'Oops', result));
      }
    }
  }

  // Widget buildBody() {}
  Widget buildAdditionalBody() {
    if (widget.poi.lat != null && widget.poi.lng != null && initializedDates) {
      return Column(
        children: [
          addVerticalSpace(spacing_24),
          NearbyPlaces(
            lat: widget.poi.lat,
            lng: widget.poi.lng,
            startDate: startDate,
            endDate: endDate,
            addVisit: addVisit,
          ),
        ],
      );
    }
    return Container();
  }

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
                  buildAdditionalBody(),
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
                          //
                          if (pickedDate != null) {
                            //
                            VisitModel visit = VisitModel(
                              id: widget.poi.id,
                              placeId: false,
                              fsqId: false,
                              poiId: true,
                              name: widget.poi.name,
                              imageUrl: widget.poi.image,
                              sequence: 0,
                              lat: widget.poi.lat,
                              lng: widget.poi.lng,
                              additionalData: {},
                              addedBy: userId,
                            );
                            //
                            await addVisit(pickedDate, visit);
                          }
                        }
                      },
                      icon: const Icon(Icons.add_location),
                      label: ButtonChildProcessing(
                        processing: processing,
                        title: 'Add Visit',
                      ),
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
