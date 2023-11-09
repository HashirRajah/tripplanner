import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/models/country_info_model.dart';
import 'package:tripplanner/screens/travel_info_screens/embassy_section.dart';
import 'package:tripplanner/screens/webview_screens/webview.dart';
import 'package:tripplanner/services/country_flag_services.dart';
import 'package:tripplanner/services/rest_countries_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class CountryInfoSection extends StatefulWidget {
  final String countryCode;
  //
  const CountryInfoSection({
    super.key,
    required this.countryCode,
  });

  @override
  State<CountryInfoSection> createState() => _CountryInfoSectionState();
}

class _CountryInfoSectionState extends State<CountryInfoSection> {
  final String svgFilePath = 'assets/svgs/question.svg';
  bool dataFetched = false;
  bool countryInfoError = false;
  late final CountryInfoModel ciModel;
  final RestCountriesService rcService = RestCountriesService();

  //
  @override
  void initState() {
    super.initState();
    //
    fetchCountryInfo();
  }

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
    if (dataFetched) {
      setState(() {
        dataFetched = false;
      });
    }
    //
    dynamic result = await rcService.getCountryInfo(widget.countryCode);
    //
    if (result == null) {
      countryInfoError = true;
    } else {
      ciModel = result;
    }
    //
    dataFetched = true;
    setState(() {});
  }

  //
  Widget buildBody() {
    if (!dataFetched) {
      return const Center(child: CircularProgressIndicator());
    } else if (countryInfoError) {
      return ErrorStateWidget(
        action: fetchCountryInfo,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.network(
              CountryFlagService(country: widget.countryCode).getUrl(64),
              height: 64,
            ),
          ),
          addVerticalSpace(spacing_8),
          Row(
            children: [
              const Icon(Icons.public),
              addHorizontalSpace(spacing_8),
              Text(
                'Country',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          addVerticalSpace(spacing_8),
          Text(
            ciModel.officialName,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          addVerticalSpace(spacing_16),
          Row(
            children: [
              const Icon(Icons.flag),
              addHorizontalSpace(spacing_8),
              Text(
                'Independent',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          addVerticalSpace(spacing_8),
          Text(
            ciModel.independent ? 'Yes' : 'No',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          addVerticalSpace(spacing_16),
          Row(
            children: [
              const Icon(Icons.center_focus_strong),
              addHorizontalSpace(spacing_8),
              Text(
                'Capitals',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          addVerticalSpace(spacing_8),
          SizedBox(
            height: spacing_24,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: spacing_16),
                  child: Text(
                    ciModel.capital[index],
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              },
              itemCount: ciModel.capital.length,
            ),
          ),
          addVerticalSpace(spacing_16),
          Row(
            children: [
              const Icon(Icons.people),
              addHorizontalSpace(spacing_8),
              Text(
                'Population',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          addVerticalSpace(spacing_8),
          Text(
            ciModel.population.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          addVerticalSpace(spacing_16),
          Row(
            children: [
              const Icon(Icons.money),
              addHorizontalSpace(spacing_8),
              Text(
                'Currencies',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          addVerticalSpace(spacing_8),
          SizedBox(
            height: spacing_24,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: spacing_16),
                  child: Text(
                    '${ciModel.currencies[index].code} - ${ciModel.currencies[index].name}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              },
              itemCount: ciModel.currencies.length,
            ),
          ),
          addVerticalSpace(spacing_16),
          Row(
            children: [
              const Icon(Icons.language),
              addHorizontalSpace(spacing_8),
              Text(
                'Common Languages',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          addVerticalSpace(spacing_8),
          SizedBox(
            height: spacing_24,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: spacing_16),
                  child: Text(
                    ciModel.languages[index].lang,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              },
              itemCount: ciModel.languages.length,
            ),
          ),
          addVerticalSpace(spacing_8),
          Center(
            child: ElevatedButtonWrapper(
              childWidget: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        int index = 0;
                        //
                        if (ciModel.languages.length > 1) {
                          if (ciModel.languages[0].lang.toLowerCase() ==
                              'english') {
                            index = 1;
                          }
                        }
                        //

                        final String url =
                            'https://translate.google.com/?sl=en&tl=${ciModel.languages[index].langCode.substring(0, 2)}&op=translate';

                        //
                        return WebViewScreen(url: url);
                      },
                    ),
                  );
                },
                label: const Text('Google Translate'),
                icon: const Icon(Icons.translate),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Did you know ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: spacing_8,
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText(
                          '?',
                          speed: const Duration(milliseconds: 96),
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
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
              10,
              screenHeight,
            ),
          ),
        ),
      ],
    );
  }
}
