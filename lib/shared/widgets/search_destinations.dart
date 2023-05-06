import 'package:flutter/material.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/services/google_maps_services/places_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/destination_suggestion_tile.dart';

class SearchDestinations extends SearchDelegate {
  final PlacesAPI placesAPI = PlacesAPI();
  //
  List<DestinationModel> predictions = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () async {
          query.isEmpty ? close(context, null) : query = '';
        },
        icon: const Icon(Icons.clear_outlined),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Placeholder();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //
    return FutureBuilder(
      future: _getPredictions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: spacing_24),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: green_10,
              ),
              itemBuilder: (context, index) {
                return DestinationSuggestionTile(
                  destination: predictions[index],
                  onTap: selectDestination,
                );
              },
              itemCount: predictions.length,
            ),
          );
        }
      },
    );
  }

  // get predictions
  Future _getPredictions() async {
    dynamic result = await placesAPI.destinationsSuggestions(query);
    //
    if (result != null) {
      predictions = result;
    }
  }

  //
  void selectDestination(BuildContext context, DestinationModel destination) {
    query = destination.description;
    //
    close(context, destination);
  }
}
