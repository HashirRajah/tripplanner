import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/visit_model.dart';
import 'package:tripplanner/screens/trip_screens/schedules_screens/vsits/visit_card.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/services/firestore_services/visit_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:timelines/timelines.dart';
import 'package:tripplanner/shared/widgets/empty_list.dart';
import 'package:tripplanner/shared/widgets/empty_sliver_list.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  //
  final String svgFilePath = 'assets/svgs/visits.svg';
  //
  late final DateTime startDate;
  late final DateTime endDate;
  late DateTime selectedDate;
  late final int daysCount;
  late final TripsCRUD tripsCRUD;
  late final VisitsCRUD visitCRUD;
  bool loadingDates = true;
  bool loadingVisits = true;
  List<VisitModel> visits = [];
  //
  @override
  void initState() {
    super.initState();
    final String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    tripsCRUD = TripsCRUD(tripId: tripId);
    visitCRUD = VisitsCRUD(tripId: tripId, userId: userId);
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
      selectedDate = startDate;
    } else if (today.isBefore(endDate)) {
      selectedDate = today;
    } else {
      selectedDate = endDate;
    }
    //
    //
    daysCount = endDate.difference(startDate).inDays + 1;
    //
    loadingDates = false;
    //
    await getVisits();
    //
    setState(() {});
  }

  //
  Future<void> getVisits() async {
    //
    if (!loadingVisits) {
      setState(() {
        loadingVisits = true;
      });
    }
    //
    visits = await visitCRUD.getVisitsForDate(selectedDate);
    //
    loadingVisits = false;
    //
    setState(() {});
  }

  //
  void deleteVisit(VisitModel visit) {
    visits.remove(visit);
    //
    setState(() {});
  }

  //
  Widget buildBody() {
    if (loadingVisits) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      //
      if (visits.isEmpty) {
        return EmptyList(
            svgFilePath: svgFilePath, message: 'No Scheduled Visits');
      } else {
        return FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            color: green_10,
            nodePosition: 0,
          ),
          builder: TimelineTileBuilder.fromStyle(
            contentsAlign: ContentsAlign.basic,
            contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(spacing_16),
              child: VisitCard(
                date: selectedDate,
                visit: visits[index],
                numberOfVisits: visits.length,
                update: getVisits,
                delete: deleteVisit,
              ),
            ),
            itemCount: visits.length,
          ),
        );
      }
      //
    }
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
                          initialSelectedDate: selectedDate,
                          selectionColor: green_10,
                          daysCount: daysCount,
                          onDateChange: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                            //
                            getVisits();
                          },
                        ),
                ),
              ),
              // schedules
              SliverPadding(
                padding: const EdgeInsets.all(spacing_16),
                sliver: SliverToBoxAdapter(
                  child: buildBody(),
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
