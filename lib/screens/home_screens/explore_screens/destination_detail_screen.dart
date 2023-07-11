import 'package:flutter/material.dart';
import 'package:tripplanner/models/city_model.dart';
import 'package:tripplanner/models/city_score_model.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/country_info_section_name.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/destination_detail_app_bar.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/scores.dart';
import 'package:tripplanner/services/teleport_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DestinationDetail extends StatefulWidget {
  final CityModel destination;
  final bool liked;
  final Function updateLikes;
  //
  const DestinationDetail({
    super.key,
    required this.destination,
    required this.liked,
    required this.updateLikes,
  });

  @override
  State<DestinationDetail> createState() => _DestinationDetailState();
}

class _DestinationDetailState extends State<DestinationDetail> {
  final TeleportAPI teleportAPI = TeleportAPI();
  //
  CityScoreModel? cityScoreModel;
  String title = '';
  String? countryCode;
  String imageLink =
      'https://images.unsplash.com/photo-1465447142348-e9952c393450?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80';
  //
  @override
  void initState() {
    super.initState();
    //
    if (widget.destination.name.toLowerCase() ==
        widget.destination.country.toLowerCase()) {
      title = widget.destination.name.toLowerCase();
    } else {
      title =
          '${widget.destination.name.toLowerCase()}+${widget.destination.country.toLowerCase()}';
    }
    //
    getCityInfo();
  }

  //
  Future<void> getCityInfo() async {
    dynamic result = await teleportAPI.getScores(widget.destination.name);
    //
    if (result != null) {
      setState(() {
        cityScoreModel = result;
        if (cityScoreModel!.imageLink != '') {
          imageLink = cityScoreModel!.imageLink;
        }
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // Widget buildBody() {}

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DestinationDetailSliverAppBar(
            title: title,
            imageLink: imageLink,
            liked: widget.liked,
            destinationId: widget.destination.id,
            updateLikes: widget.updateLikes,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(spacing_24),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    widget.destination.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          letterSpacing: 3.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  addVerticalSpace(spacing_24),
                  Container(
                    padding: const EdgeInsets.all(spacing_16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: tripCardColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'According to Teleport',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        addVerticalSpace(spacing_8),
                        Text(
                          cityScoreModel != null
                              ? cityScoreModel!.getParsedSummary()
                              : '',
                        ),
                        addVerticalSpace(spacing_8),
                        Scores(
                          scores: cityScoreModel != null
                              ? cityScoreModel!.scores
                              : [],
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(spacing_24),
                  CountryInfoSectionWithName(
                      name: widget.destination.country.toLowerCase()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
