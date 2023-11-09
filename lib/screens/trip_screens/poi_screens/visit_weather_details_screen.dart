import 'package:flutter/material.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/models/weather_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/visit_poi_details_app_bar.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/services/openweather_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class VisitWeatherDetailsScreen extends StatefulWidget {
  //
  final double lat;
  final double lng;
  final String name;
  final String imageLink;
  //
  const VisitWeatherDetailsScreen({
    super.key,
    required this.lat,
    required this.lng,
    required this.name,
    required this.imageLink,
  });

  @override
  State<VisitWeatherDetailsScreen> createState() =>
      _VisitWeatherDetailsScreenState();
}

class _VisitWeatherDetailsScreenState extends State<VisitWeatherDetailsScreen> {
  String imageLink =
      'https://images.unsplash.com/photo-1465447142348-e9952c393450?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80';
  //
  bool fetchedWeatherData = false;
  final OpenWeatherAPI openWeatherAPI = OpenWeatherAPI();
  late WeatherModel weather;
  //
  @override
  void initState() {
    super.initState();
    //
    //
    fetchInfo();
  }

  //

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> fetchInfo() async {
    //
    dynamic result =
        await openWeatherAPI.getCurrentWeather(widget.lat, widget.lng);
    //
    if (result != null) {
      weather = result;
      fetchedWeatherData = true;
    }
    //
    setState(() {});
  }

  //
  List<Widget> buildWeatherBody() {
    List<Widget> weatherBody = [];
    //
    if (fetchedWeatherData) {
      weatherBody.add(
        Text(
          '${weather.temp.ceil()} ℃',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
      weatherBody.add(addVerticalSpace(spacing_8));
      weatherBody.add(
        Text(
          '${weather.main} - ${weather.description}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
      weatherBody.add(addVerticalSpace(spacing_16));
      //
      weatherBody.add(
        Text(
          '${weather.max}° / ${weather.min}° Feels like ${weather.feelsLike.ceil()}℃',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
      weatherBody.add(addVerticalSpace(spacing_16));
      weatherBody.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.wind_power),
          addHorizontalSpace(spacing_8),
          Text(
            '${weather.wind} m/s',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ));
      weatherBody.add(addVerticalSpace(spacing_16));
      weatherBody.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.water_drop),
          addHorizontalSpace(spacing_8),
          Text(
            '${weather.humidity} %',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ));
    }
    //
    return weatherBody;
  }

  //
  @override
  void dispose() {
    //
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          VisitPOIDetailSliverAppBar(
            imageLink: widget.imageLink == '' ? imageLink : widget.imageLink,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(spacing_24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cloud,
                              color: green_10,
                            ),
                            addHorizontalSpace(spacing_16),
                            Text(
                              'Current Weather',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        addHorizontalSpace(spacing_24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildWeatherBody(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
