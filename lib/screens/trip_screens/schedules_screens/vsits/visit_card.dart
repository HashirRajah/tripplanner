import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/visit_model.dart';
import 'package:tripplanner/screens/maps/simple_map_screen.dart';
import 'package:tripplanner/screens/trip_screens/schedules_screens/vsits/edit_visit_form.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/firestore_services/visit_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class VisitCard extends StatefulWidget {
  final VisitModel visit;
  final int numberOfVisits;
  final DateTime date;
  final Function update;
  final Function delete;
  //
  const VisitCard({
    super.key,
    required this.date,
    required this.visit,
    required this.numberOfVisits,
    required this.update,
    required this.delete,
  });

  @override
  State<VisitCard> createState() => _VisitCardState();
}

class _VisitCardState extends State<VisitCard> {
  final LocalService localService = LocalService();
  late int visitSequence;
  late UsersCRUD usersCRUD;
  late String userId;
  late VisitsCRUD visitsCRUD;
  String imageLink =
      'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1121&q=80';
  //
  @override
  void initState() {
    super.initState();
    //
    final String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    visitSequence = widget.visit.sequence;
    //
    visitsCRUD = VisitsCRUD(tripId: tripId, userId: userId);
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  void editVisit() {
    //
    double screenHeight = getScreenHeight(context);
    //
    showModalBottomSheet(
      clipBehavior: Clip.hardEdge,
      backgroundColor: docTileColor,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (newContext) {
        return Container(
          padding: const EdgeInsets.all(spacing_16),
          height: getXPercentScreenHeight(60, screenHeight),
          decoration: BoxDecoration(
            color: docTileColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Edit Visit',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              addVerticalSpace(spacing_16),
              Center(
                child: SizedBox(
                  height: (spacing_8 * 20),
                  child: ListWheelScrollView.useDelegate(
                    controller: FixedExtentScrollController(
                      initialItem: visitSequence - 1,
                    ),
                    onSelectedItemChanged: (value) {
                      visitSequence = (value + 1);
                    },
                    itemExtent: 100,
                    perspective: 0.005,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Text(
                          '${(index + 1)}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        );
                      },
                      childCount: widget.numberOfVisits,
                    ),
                  ),
                ),
              ),
              addVerticalSpace(spacing_16),
              EditVisitForm(edit: edit),
            ],
          ),
        );
      },
    );
  }

  //
  Future<void> edit() async {
    //
    if (visitSequence != widget.visit.sequence) {
      //
      dynamic result = await visitsCRUD.editVisit(
        widget.date,
        visitSequence,
        widget.visit.sequence,
      );
      //
      if (result != null) {
        Fluttertoast.showToast(
          msg: "An Error Occurred!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: green_10.withOpacity(0.5),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        widget.update();
        //
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: "No change in schedule!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: green_10.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: spacing_8),
      child: Stack(
        children: <Widget>[
          Card(
            elevation: 3.0,
            color: tripCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomRight: Radius.elliptical(
                          spacing_128,
                          spacing_104,
                        ),
                      ),
                      child: Image.network(
                        widget.visit.imageUrl ?? imageLink,
                        fit: BoxFit.cover,
                        width: (spacing_8 * 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(spacing_16),
                      child: Text(
                        'Visit: ${widget.visit.sequence}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(spacing_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.visit.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      addVerticalSpace(spacing_24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: white_60,
                            child: IconButton(
                              onPressed: () async {
                                //
                                editVisit();
                              },
                              icon: const Icon(Icons.edit_outlined),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: green_10,
                            foregroundColor: white_60,
                            child: IconButton(
                              onPressed: () async {
                                //
                                if (widget.visit.lat != null &&
                                    widget.visit.lng != null) {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      LatLng location = LatLng(
                                          widget.visit.lat!, widget.visit.lng!);
                                      //
                                      return SimpleMapScreen(place: location);
                                    },
                                  ));
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "No location available!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: green_10.withOpacity(0.5),
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                              icon: const Icon(Icons.map_outlined),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: green_10,
                            foregroundColor: white_60,
                            child: IconButton(
                              onPressed: () async {},
                              icon: const Icon(Icons.info_outline),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: errorColor,
                            foregroundColor: white_60,
                            child: IconButton(
                              onPressed: userId == widget.visit.addedBy
                                  ? () async {
                                      //
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.confirm,
                                        text: 'Delete visit',
                                        confirmBtnColor: errorColor,
                                        customAsset: 'assets/gifs/bin.gif',
                                        onConfirmBtnTap: () async {
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                          //
                                          dynamic result =
                                              await visitsCRUD.removeVisit(
                                            widget.date,
                                            widget.visit.docId!,
                                          );
                                          //
                                          if (result != null) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(errorSnackBar(
                                                context,
                                                'Error',
                                                'An unexpected error occurred',
                                              ));
                                            }
                                          } else {
                                            await widget.delete(widget.visit);
                                          }
                                        },
                                      );
                                      //
                                    }
                                  : null,
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
