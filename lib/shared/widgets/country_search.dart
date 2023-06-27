import 'package:flutter/material.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/services/google_maps_services/places_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/country_suggestion_tile.dart';

class SearchCountries extends SearchDelegate {
  final PlacesAPI placesAPI = PlacesAPI();
  //
  List<CountryModel> predictions = [];

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
          //
          if (snapshot.hasData) {
            return const Center(
              child: Text('Please enter at least 3 characters!'),
            );
          }
          //
          if (predictions.isEmpty) {
            return const Center(
              child: Text('No results found!'),
            );
          }
          //
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: spacing_8),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: green_10,
              ),
              itemBuilder: (context, index) {
                return CountrySuggestionTile(
                  country: predictions[index],
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
    //
    if (query.length < 3) {
      return 'length-less-than-3';
    }
    //
    dynamic result = await placesAPI.countrySuggestions(query);
    //
    if (result != null) {
      predictions = result;
    }
  }

  //
  void selectDestination(BuildContext context, CountryModel country) {
    query = country.name;
    //
    close(context, country);
  }
}
