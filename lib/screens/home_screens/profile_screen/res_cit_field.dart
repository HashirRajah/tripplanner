import 'package:flutter/material.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/services/country_flag_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/country_search.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ResidencyCitizenshipField extends StatefulWidget {
  //
  final CountryModel country;
  final Function changeCountry;
  //
  const ResidencyCitizenshipField({
    super.key,
    required this.country,
    required this.changeCountry,
  });

  @override
  State<ResidencyCitizenshipField> createState() =>
      _ResidencyCitizenshipFieldState();
}

class _ResidencyCitizenshipFieldState extends State<ResidencyCitizenshipField> {
  //
  String imageUrl = '';
  late CountryModel country;
  //
  @override
  void initState() {
    super.initState();
    //
    country = widget.country;
    //
    getFlag();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  void getFlag() {
    final CountryFlagService countryFlagService =
        CountryFlagService(country: country.code);
    //
    String url = countryFlagService.getUrl(64);
    //
    setState(() {
      imageUrl = url;
    });
  }

  Widget getHeader() {
    if (imageUrl == '') {
      return const Icon(Icons.flag);
    } else {
      return Image.network(
        imageUrl,
        height: spacing_32,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.flag);
        },
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spacing_8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: tripCardColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              getHeader(),
              addHorizontalSpace(spacing_16),
              Text(widget.country.name),
            ],
          ),
          IconButton(
            onPressed: () async {
              dynamic result = await showSearch(
                context: context,
                delegate: SearchCountries(),
              );
              debugPrint(result.toString());
              //
              if (result != null && context.mounted) {
                //
                setState(() {
                  widget.changeCountry(result);
                  country = result;
                  getFlag();
                });
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
