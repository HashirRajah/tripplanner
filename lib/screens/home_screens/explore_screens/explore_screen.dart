import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/explore_app_bar.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/popular_section/popular_section.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/recommendation_section/recommendation_section.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final UsersCRUD usersCRUD;
  List<int> likes = [];
  //
  @override
  void initState() {
    super.initState();
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    getLikes();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  void updateLikes(bool add, int id) {
    if (add) {
      likes.add(id);
    } else {
      likes.remove(id);
    }
    //
    setState(() {});
  }

  //
  Future<void> getLikes() async {
    dynamic result = await usersCRUD.getAllLikedDestinations();
    //
    if (result.length > 0) {
      setState(() {
        likes = result;
      });
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const ExploreSliverAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(spacing_16),
          sliver: RecommendationSection(
            likes: likes,
            updateLikes: updateLikes,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(spacing_16),
          sliver: PopularSection(
            likes: likes,
            updateLikes: updateLikes,
          ),
        ),
      ],
    );
  }
}
