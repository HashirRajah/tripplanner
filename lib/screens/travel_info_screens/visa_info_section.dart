import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/services/rest_countries_services.dart';
import 'package:tripplanner/services/travel_info_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class VisaInfoSection extends StatefulWidget {
  final String countryCode;
  //
  const VisaInfoSection({
    super.key,
    required this.countryCode,
  });

  @override
  State<VisaInfoSection> createState() => _VisaInfoSectionState();
}

class _VisaInfoSectionState extends State<VisaInfoSection> {
  final String svgFilePath = 'assets/svgs/find.svg';
  bool dataFetched = false;
  bool infoError = false;
  late final String data;
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
        'MU', widget.countryCode.toUpperCase());
    //
    if (result == null) {
      infoError = true;
    } else {
      data = result;
    }
    //
    dataFetched = true;
    setState(() {});
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Visa',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          addVerticalSpace(spacing_16),
          Text(
            'E-visa',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          addVerticalSpace(spacing_8),
          Text(
            data,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          addVerticalSpace(spacing_16),
          Center(
            child: ElevatedButtonWrapper(
              childWidget: ElevatedButton.icon(
                onPressed: () async {
                  final Uri url = Uri.parse('https://www.visahq.com');
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
