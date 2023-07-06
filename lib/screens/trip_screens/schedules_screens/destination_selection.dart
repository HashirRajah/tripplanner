import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/cubits/additionsl_user_info_cubit/additional_user_info_cubit.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/models/destination_model.dart';
import 'package:tripplanner/services/country_flag_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/country_search.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DestinationField extends StatefulWidget {
  //
  final DestinationModel? destinationModel;
  final Function function;
  //
  const DestinationField({
    super.key,
    required this.destinationModel,
    required this.function,
  });

  @override
  State<DestinationField> createState() => _DestinationFieldState();
}

class _DestinationFieldState extends State<DestinationField> {
  //
  String imageUrl = '';
  //
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  void getFlag() {
    if (widget.destinationModel != null) {
      final CountryFlagService countryFlagService =
          CountryFlagService(country: widget.destinationModel!.countryCode);
      //
      String url = countryFlagService.getUrl(64);
      //
      setState(() {
        imageUrl = url;
      });
    }
  }

  Widget getHeader() {
    getFlag();
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
    //
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
              Text(
                widget.destinationModel != null
                    ? widget.destinationModel!.description
                    : 'Loading...',
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              widget.function();
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
