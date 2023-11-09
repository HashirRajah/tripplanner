import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/currency_exchnage_section/currency_exchange_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class CurrencyExchangeSection extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/currency.svg';
  //
  const CurrencyExchangeSection({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            padding: const EdgeInsets.all(spacing_16),
            height: spacing_120,
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          Hero(
            tag: 'currency-exchange',
            child: SvgPicture.asset(
              svgFilePath,
              height: (spacing_8 * 20),
            ),
          ),
          Positioned(
            right: spacing_16,
            bottom: spacing_8,
            child: CircleAvatar(
              backgroundColor: green_10,
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (newContext) => BlocProvider.value(
                        value: BlocProvider.of<TripIdCubit>(context),
                        child: const CurrencyExchangeScreen(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward_outlined),
              ),
            ),
          ),
          Positioned(
            right: spacing_16,
            top: spacing_48,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Currency Rates',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: green_10,
                      ),
                ),
                addVerticalSpace(spacing_8),
                Text(
                  'Find foreign exchange rates',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: green_10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
