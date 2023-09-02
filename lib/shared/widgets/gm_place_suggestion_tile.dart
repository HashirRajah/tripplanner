import 'package:flutter/material.dart';
import 'package:tripplanner/models/visit_model.dart';

class GMPlaceSuggestionTile extends StatelessWidget {
  final VisitModel place;
  final Function onTap;
  //
  const GMPlaceSuggestionTile({
    super.key,
    required this.place,
    required this.onTap,
  });
  //

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.name),
      onTap: () => onTap(context, place),
    );
  }
}
