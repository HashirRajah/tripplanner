import 'package:flutter/material.dart';
import 'package:tripplanner/screens/webview_screens/webview.dart';
import 'package:tripplanner/services/rest_countries_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EmbassySection extends StatefulWidget {
  final String country;
  //
  const EmbassySection({
    super.key,
    required this.country,
  });

  @override
  State<EmbassySection> createState() => _EmbassySectionState();
}

class _EmbassySectionState extends State<EmbassySection> {
  final String svgFilePath = 'assets/svgs/investigate.svg';
  bool dataFetched = false;
  bool infoError = false;
  late String countryName;
  final RestCountriesService rcService = RestCountriesService();
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
    if (dataFetched) {
      setState(() {
        dataFetched = false;
      });
    }
    //
    dynamic result = await rcService.getCountryName(widget.country);
    //
    if (result == null) {
      infoError = true;
    } else {
      countryName = result;
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
      return ElevatedButtonWrapper(
        childWidget: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  final String url =
                      'https://www.embassypages.com/${countryName.toLowerCase()}';
                  print(url);
                  //
                  return WebViewScreen(url: url);
                },
              ),
            );
          },
          child: const Text('Find'),
        ),
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Container(
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
            'Embassy',
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
    );
  }
}
