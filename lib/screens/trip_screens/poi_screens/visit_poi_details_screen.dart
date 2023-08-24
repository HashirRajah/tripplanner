import 'package:flutter/material.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/models/weather_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/visit_poi_details_app_bar.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/services/openweather_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class VisitPOIDetailsScreen extends StatefulWidget {
  final int id;
  //
  const VisitPOIDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<VisitPOIDetailsScreen> createState() => _VisitPOIDetailsScreenState();
}

class _VisitPOIDetailsScreenState extends State<VisitPOIDetailsScreen> {
  String imageLink =
      'https://images.unsplash.com/photo-1465447142348-e9952c393450?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80';
  //
  bool loading = true;
  bool fetchedWeatherData = false;
  final LocalService localService = LocalService();
  final OpenWeatherAPI openWeatherAPI = OpenWeatherAPI();
  late POIModel poi;
  late WeatherModel weather;
  //
  @override
  void initState() {
    super.initState();
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
    dynamic result = await localService.getPOIDetails(
      widget.id,
    );
    //
    if (result != null) {
      poi = result;
      imageLink = poi.image;
      //
      if (poi.lat != null && poi.lng != null) {
        dynamic result =
            await openWeatherAPI.getCurrentWeather(poi.lat!, poi.lng!);
        //
        if (result != null) {
          weather = result;
          fetchedWeatherData = true;
        }
      }
    }
    //
    setState(() {
      loading = false;
    });
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
            imageLink: imageLink,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(spacing_24),
            sliver: SliverToBoxAdapter(
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          poi.name,
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        addVerticalSpace(spacing_16),
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              color: gold,
                            ),
                            addHorizontalSpace(spacing_8),
                            Text(poi.views.toString()),
                            addHorizontalSpace(spacing_16),
                            Icon(
                              Icons.favorite,
                              color: errorColor,
                            ),
                            addHorizontalSpace(spacing_8),
                            Text(poi.likes.toString()),
                          ],
                        ),
                        addVerticalSpace(spacing_24),
                        Container(
                          padding: const EdgeInsets.all(spacing_16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: tripCardColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.route,
                                color: green_30,
                              ),
                              addHorizontalSpace(spacing_16),
                              Text(
                                poi.distance,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      letterSpacing: 3.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
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
                        addVerticalSpace(spacing_24),
                        Text(
                          poi.description,
                          style:
                              const TextStyle(letterSpacing: 1.5, height: 1.5),
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
