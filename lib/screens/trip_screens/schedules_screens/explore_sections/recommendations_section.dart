import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/models/category_model.dart';
import 'package:tripplanner/models/simple_news_model.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/news_card.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class RecommendationSection extends StatefulWidget {
  final String destination;
  //
  const RecommendationSection({
    super.key,
    required this.destination,
  });

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection> {
  bool preferencesFetched = false;
  bool error = false;
  late String selectedPref;
  List<String> preferences = [];
  final LocalService localService = LocalService();
  final String title = 'Other Places';
  late String cachedDestination;
  late final UsersCRUD usersCRUD;
  //
  @override
  void initState() {
    super.initState();
    //
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    cachedDestination = widget.destination;
    //
    fetchPreferences();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> fetchPreferences() async {
    //dynamic result = await usersCRUD.getAllPreferences();
    //
    // if (result != null) {
    //   //
    //   for (int id in result) {
    //     dynamic cat = await localService.getCategory(id);
    //     //
    //     if (cat != null) {
    //       preferences.add(cat);
    //     }
    //   }
    //   //
    //   error = false;
    // } else {
    //   error = true;
    // }
    //
    preferences.add('Restaurants');
    preferences.add('Cafes');
    preferences.add('Malls');
    selectedPref = preferences[0];
    //
    setState(() {
      preferencesFetched = true;
    });
  }

  //
  List<Widget> buildBody() {
    List<Widget> body = [];
    //
    body.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(color: green_10),
        ),
      ],
    ));
    //
    body.add(addVerticalSpace(spacing_8));

    //
    if (preferencesFetched && !error) {
      //
      body.add(SizedBox(
        height: (spacing_8 * 7),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                selectedPref = preferences[index];
                //
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(spacing_16),
                margin: const EdgeInsets.only(left: spacing_16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: selectedPref == preferences[index]
                      ? green_10
                      : tripCardColor,
                ),
                child: Text(
                  preferences[index],
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: selectedPref == preferences[index]
                            ? white_60
                            : Colors.black,
                      ),
                ),
              ),
            );
          },
          itemCount: preferences.length,
          scrollDirection: Axis.horizontal,
        ),
      ));
    }

    //
    return body;
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    if (cachedDestination != widget.destination) {
      cachedDestination = widget.destination;
    }
    //
    return Container(
      margin: const EdgeInsets.only(bottom: spacing_24),
      child: Column(
        children: buildBody(),
      ),
    );
  }
}
