import 'package:flutter/material.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class VisitCard extends StatefulWidget {
  //
  const VisitCard({super.key});

  @override
  State<VisitCard> createState() => _VisitCardState();
}

class _VisitCardState extends State<VisitCard> {
  final LocalService localService = LocalService();
  late UsersCRUD usersCRUD;
  String imageLink =
      'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1121&q=80';
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
                          spacing_104,
                          spacing_104,
                        ),
                      ),
                      child: Image.network(
                        imageLink,
                        fit: BoxFit.cover,
                        width: (spacing_8 * 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: spacing_16),
                      child: Text(
                        'Visit: 1',
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
                        'Place Name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      addVerticalSpace(spacing_8),
                      Text(
                        'Current Weather',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
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
                              },
                              icon: const Icon(Icons.map_outlined),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: green_10,
                            foregroundColor: white_60,
                            child: IconButton(
                              onPressed: () async {
                                //
                              },
                              icon: const Icon(Icons.info_outline),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: errorColor,
                            foregroundColor: white_60,
                            child: IconButton(
                              onPressed: () async {
                                //
                              },
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
