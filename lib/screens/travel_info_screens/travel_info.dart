import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/screens/travel_info_screens/country_info_section.dart';
import 'package:tripplanner/screens/travel_info_screens/embassy_section.dart';
import 'package:tripplanner/screens/travel_info_screens/news_section.dart';
import 'package:tripplanner/screens/travel_info_screens/visa_info_section.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class TravelInfo extends StatefulWidget {
  //
  final DestinationModel destination;
  //
  const TravelInfo({
    super.key,
    required this.destination,
  });

  @override
  State<TravelInfo> createState() => _TravelInfoState();
}

class _TravelInfoState extends State<TravelInfo> {
  bool loading = true;
  late final UsersCRUD usersCRUD;
  late final String userId;
  String? residency;
  String? residencyFullName;
  String? citizenship;
  //
  @override
  void initState() {
    super.initState();
    //
    userId = Provider.of<User?>(context, listen: false)!.uid;
    usersCRUD = UsersCRUD(uid: userId);
    //
    fetchUserInfo();
  }

  //
  Future<void> fetchUserInfo() async {
    dynamic residencyResult = await usersCRUD.getResidency();
    dynamic citizenshipResult = await usersCRUD.getCitizenship();
    dynamic residencyFullNameResult = await usersCRUD.getResidencyFullName();
    //
    if (residencyResult != null) {
      residency = residencyResult;
    }
    if (citizenshipResult != null) {
      citizenship = citizenshipResult;
    }
    if (residencyFullNameResult != null) {
      residencyFullName = residencyFullNameResult;
    }
    //
    setState(() {
      loading = false;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(spacing_24),
      child: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                VisaInfoSection(
                  countryName: widget.destination.countryName,
                  residency: residency ?? '',
                  citizenship: citizenship ?? '',
                ),
                addVerticalSpace(spacing_24),
                EmbassySection(
                  country: widget.destination.countryName,
                  residency: residencyFullName ?? '',
                ),
                addVerticalSpace(spacing_24),
                CountryInfoSection(
                  countryCode: widget.destination.countryCode,
                ),
                addVerticalSpace(spacing_24),
                NewsSection(
                  destination: widget.destination.description,
                ),
              ],
            ),
    );
  }
}
