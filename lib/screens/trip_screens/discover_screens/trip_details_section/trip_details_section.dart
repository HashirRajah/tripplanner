import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/trip_details_model.dart';
import 'package:tripplanner/screens/home_screens/add_trip_screen/edit_trip_screen.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/destinations_tags.dart';
import 'package:tripplanner/shared/widgets/simple_destination_tag.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TripDetailsSection extends StatefulWidget {
  //
  const TripDetailsSection({
    super.key,
  });

  @override
  State<TripDetailsSection> createState() => _TripDetailsSectionState();
}

class _TripDetailsSectionState extends State<TripDetailsSection> {
  //
  bool loading = true;
  final TripsCRUD tripsCRUD = TripsCRUD();
  late final String tripId;
  late TripDetailsModel tripDetails;
  //
  @override
  void initState() {
    super.initState();
    //
    tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    //
    fetchTripDetails();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> fetchTripDetails() async {
    dynamic result = await tripsCRUD.getTripDetails(
      tripId,
    );
    //
    if (result != null) {
      tripDetails = result;
    }
    //
    setState(() {
      loading = false;
    });
  }
  //

  //
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      margin: const EdgeInsets.only(bottom: spacing_16),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(spacing_16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: tripCardColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tripDetails.title,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: green_10,
                                  ),
                        ),
                        addVerticalSpace(spacing_16),
                        Row(
                          children: [
                            const Icon(Icons.date_range),
                            addHorizontalSpace(spacing_16),
                            Text(
                              tripDetails.getDateFormatted(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: green_10,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        addVerticalSpace(spacing_16),
                        Text(
                          'Destinations',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: green_10,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        addVerticalSpace(spacing_16),
                        SizedBox(
                          height: spacing_40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return SimpleDestinationTag(
                                destination:
                                    tripDetails.destinations[index].description,
                                flagUrl: tripDetails
                                            .destinations[index].countryCode !=
                                        'NONE'
                                    ? tripDetails.destinations[index]
                                        .getFlagUrl()
                                    : 'NONE',
                                position: index,
                              );
                            },
                            itemCount: tripDetails.destinations.length,
                          ),
                        ),
                        addVerticalSpace(spacing_40),
                      ],
                    ),
            ),
          ),
          Positioned(
            bottom: spacing_16,
            right: spacing_16,
            child: CircleAvatar(
              backgroundColor: green_10,
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (newContext) {
                      return BlocProvider.value(
                        value: BlocProvider.of<TripIdCubit>(context),
                        child: EditTripScreen(
                          reload: fetchTripDetails,
                        ),
                      );
                    },
                  ));
                },
                icon: const Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
