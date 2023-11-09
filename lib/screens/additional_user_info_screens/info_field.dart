import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/additionsl_user_info_cubit/additional_user_info_cubit.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/services/country_flag_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/country_search.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class InfoField extends StatefulWidget {
  //
  final String type;
  //
  const InfoField({super.key, required this.type});

  @override
  State<InfoField> createState() => _InfoFieldState();
}

class _InfoFieldState extends State<InfoField> {
  //
  String imageUrl = '';
  late CountryModel country;
  //
  @override
  void initState() {
    super.initState();
    //
    changeCountry();
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
  void changeCountry() {
    if (widget.type == 'residency') {
      country = BlocProvider.of<AdditionalUserInfoCubit>(context).residency!;
    } else {
      country = BlocProvider.of<AdditionalUserInfoCubit>(context).citizenship!;
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
              Text(country.name),
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
                if (widget.type == 'residency') {
                  BlocProvider.of<AdditionalUserInfoCubit>(context).residency =
                      result;
                } else {
                  BlocProvider.of<AdditionalUserInfoCubit>(context)
                      .citizenship = result;
                }
                //
                setState(() {
                  changeCountry();
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
