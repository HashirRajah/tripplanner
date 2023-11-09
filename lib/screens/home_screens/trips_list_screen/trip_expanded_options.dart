import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/screens/home_screens/share_screen/share_screen.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:quickalert/quickalert.dart';

class TripsExpandedOptions extends StatelessWidget {
  final String id;

  const TripsExpandedOptions({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -1.0,
      top: -1.0,
      child: Container(
        decoration: BoxDecoration(
          color: searchBarColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              highlightColor: green_10,
              splashColor: green_10.withOpacity(0.5),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (newContext) {
                      return ShareScreen(
                        tripId: id,
                      );
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.share,
                color: green_10,
              ),
            ),
            IconButton(
              highlightColor: errorColor,
              splashColor: errorColor.withOpacity(0.5),
              onPressed: () async {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  text: 'Delete trip permanently',
                  confirmBtnColor: errorColor,
                  customAsset: 'assets/gifs/bin.gif',
                  onConfirmBtnTap: () async {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                    //
                    dynamic result =
                        await RepositoryProvider.of<TripsCRUD>(context)
                            .deleteTrip(id);
                  },
                );
                //
              },
              icon: Icon(
                Icons.delete_forever_outlined,
                color: errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
