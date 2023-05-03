import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/business_logic/blocs/bloc/trip_list_bloc.dart';
import 'package:tripplanner/models/trip_card_model.dart';
import 'package:tripplanner/models/trip_model.dart';
import 'package:tripplanner/screens/home_screens/trips_list_screen/trip_card.dart';
import 'package:tripplanner/services/firestore_services/trips_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:provider/provider.dart';

class TripsList extends StatefulWidget {
  const TripsList({super.key});

  @override
  State<TripsList> createState() => _TripsListState();
}

class _TripsListState extends State<TripsList> {
  final String svgFilePath = 'assets/svgs/empty.svg';
  final String errorSvgFilePath = 'assets/svgs/error.svg';
  //

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return BlocBuilder<TripListBloc, TripListState>(
      builder: (context, state) {
        if (state is LoadingTripList) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: <Widget>[
                  addVerticalSpace(spacing_24),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        //
        if (state is TripListLoaded) {
          if (state.trips.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(
                child: Column(
                  children: <Widget>[
                    addVerticalSpace(spacing_24),
                    SvgPicture.asset(
                      svgFilePath,
                      height: getXPercentScreenHeight(30, screenHeight),
                    ),
                    addVerticalSpace(spacing_24),
                    Text(
                      'No Trips',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SliverPadding(
              padding: const EdgeInsets.all(spacing_24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return TripCard(
                      trip: state.trips[index],
                    );
                  },
                  childCount: state.trips.length,
                ),
              ),
            );
          }
        }
        //
        return SliverToBoxAdapter(
          child: Center(
            child: Column(
              children: <Widget>[
                addVerticalSpace(spacing_24),
                SvgPicture.asset(
                  errorSvgFilePath,
                  height: getXPercentScreenHeight(30, screenHeight),
                ),
                addVerticalSpace(spacing_24),
                Text(
                  'An error occurred😥',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
