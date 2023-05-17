import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/screens/trip_screens/discover_screens/currency_exchnage_section/currency_exchange_form.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class CurrencyExchangeScreen extends StatelessWidget {
  final String screenTitle = 'Currency Exchange';
  final String svgFilePath = 'assets/svgs/currency.svg';
  //
  const CurrencyExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
          centerTitle: true,
          systemOverlayStyle: overlayStyle,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(spacing_24),
            child: Center(
              child: Column(
                crossAxisAlignment: screenOrientation == Orientation.portrait
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: 'currency-exchange',
                      child: SvgPicture.asset(
                        svgFilePath,
                        height: getXPercentScreenHeight(25, screenHeight),
                      ),
                    ),
                  ),
                  addVerticalSpace(spacing_24),
                  const CurrencyExchangeForm(title: 'Convert'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
