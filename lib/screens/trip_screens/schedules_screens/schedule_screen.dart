import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/schedules_screens/vsits/visit_card.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:timelines/timelines.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  //
  late final DateTime startDate;
  late final DateTime endDate;
  late final DateTime initialDate;
  late final int daysCount;
  late final TripsCRUD tripsCRUD;
  bool loadingDates = true;
  //
  @override
  void initState() {
    super.initState();
    final String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    //
    tripsCRUD = TripsCRUD(tripId: tripId);
    //
    getDates();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> getDates() async {
    //
    dynamic result = await tripsCRUD.getStartAndEndDates();
    //
    startDate = DateTime.parse(result['start']);
    endDate = DateTime.parse(result['end']);
    DateTime today = DateTime.now();
    //
    if (today.isBefore(startDate)) {
      initialDate = startDate;
    } else if (today.isBefore(endDate)) {
      initialDate = today;
    } else {
      initialDate = endDate;
    }
    //
    daysCount = endDate.difference(startDate).inDays + 1;
    //
    loadingDates = false;
    //
    setState(() {});
  }

  //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(spacing_8),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CustomScrollView(
            slivers: [
              // dates
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(spacing_16),
                  margin: const EdgeInsets.only(bottom: spacing_8),
                  decoration: BoxDecoration(
                    color: docTileColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: loadingDates
                      ? const SizedBox(
                          height: spacing_96,
                        )
                      : DatePicker(
                          startDate,
                          height: spacing_96,
                          initialSelectedDate: initialDate,
                          selectionColor: green_10,
                          daysCount: daysCount,
                        ),
                ),
              ),
              // schedules
              SliverPadding(
                padding: const EdgeInsets.all(spacing_16),
                sliver: SliverToBoxAdapter(
                  child: FixedTimeline.tileBuilder(
                    theme: TimelineThemeData(
                      color: green_10,
                      nodePosition: 0,
                    ),
                    builder: TimelineTileBuilder.fromStyle(
                      contentsAlign: ContentsAlign.basic,
                      contentsBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: VisitCard(),
                      ),
                      itemCount: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add_location),
          )
        ],
      ),
    );
  }
}
