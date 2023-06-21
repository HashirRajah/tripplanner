import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/models/info_model.dart';
import 'package:tripplanner/models/visa_info_model.dart';
import 'package:tripplanner/services/travel_info_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class VisaInfoSection extends StatefulWidget {
  final String countryName;
  //
  const VisaInfoSection({
    super.key,
    required this.countryName,
  });

  @override
  State<VisaInfoSection> createState() => _VisaInfoSectionState();
}

class _VisaInfoSectionState extends State<VisaInfoSection> {
  final String svgFilePath = 'assets/svgs/find.svg';
  bool dataFetched = false;
  bool infoError = false;
  VisaInfoModel? visaInfo;
  final TravelInfoService travelInfoService = TravelInfoService();
  //
  @override
  void initState() {
    super.initState();
    //
    fetchCountryInfo();
  }

  //
  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> fetchCountryInfo() async {
    //
    if (!dataFetched) {
      setState(() {
        dataFetched = false;
      });
    }
    dynamic result = await travelInfoService.getVisaInfo(
        'MU', 'MU', widget.countryName.toLowerCase());
    //
    if (result == null) {
      infoError = true;
    } else {
      visaInfo = result;
    }
    //
    dataFetched = true;
    setState(() {});
  }

  //
  Widget buildInfos() {
    List<Widget> infos = [];
    //
    for (InfoModel info in visaInfo!.requirements) {
      infos.add(Container(
        margin: const EdgeInsets.only(bottom: spacing_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              info.title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            addVerticalSpace(spacing_8),
            Text(info.content),
          ],
        ),
      ));
    }
    //
    for (InfoModel info in visaInfo!.general) {
      infos.add(Container(
        margin: const EdgeInsets.only(bottom: spacing_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              info.title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            addVerticalSpace(spacing_8),
            Text(info.content),
          ],
        ),
      ));
    }
    //
    for (InfoModel info in visaInfo!.restrictions) {
      infos.add(Container(
        margin: const EdgeInsets.only(bottom: spacing_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              info.title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            addVerticalSpace(spacing_8),
            Text(info.content),
          ],
        ),
      ));
    }
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: infos,
    );
  }

  //
  Widget buildBody() {
    if (!dataFetched) {
      return const Center(child: CircularProgressIndicator());
    } else if (infoError) {
      return ErrorStateWidget(
        action: fetchCountryInfo,
      );
    } else {
      if (visaInfo!.status != 'ok') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Visit link for more info'),
            addVerticalSpace(spacing_16),
            Center(
              child: ElevatedButtonWrapper(
                childWidget: ElevatedButton.icon(
                  onPressed: () async {
                    final Uri url = Uri.parse(visaInfo!.url);
                    //
                    if (await canLaunchUrl(url)) {
                      launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                  label: const Text('More Info'),
                  icon: const Icon(Icons.link),
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildInfos(),
            addVerticalSpace(spacing_16),
            Center(
              child: ElevatedButtonWrapper(
                childWidget: ElevatedButton.icon(
                  onPressed: () async {
                    final Uri url = Uri.parse(visaInfo!.url);
                    //
                    if (await canLaunchUrl(url)) {
                      launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                  label: const Text('More Info'),
                  icon: const Icon(Icons.link),
                ),
              ),
            ),
          ],
        );
      }
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    //
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(spacing_16),
          decoration: BoxDecoration(
            color: tripCardColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Visa Info',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              addVerticalSpace(spacing_32),
              buildBody(),
            ],
          ),
        ),
        Positioned(
          top: -spacing_24,
          left: -spacing_8,
          child: SvgPicture.asset(
            svgFilePath,
            height: getXPercentScreenHeight(
              12,
              screenHeight,
            ),
          ),
        )
      ],
    );
  }
}
