import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/business_logic/cubits/doc_list_cubit/doc_list_cubit.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_list_filter.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_type_list.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DocumentsScreen extends StatelessWidget {
  final String svgFilePath = 'assets/svgs/documents.svg';
  final String screenTitle = 'Documents';

  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //
    double screenHeight = getScreenHeight(context);
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return BlocProvider<DocListCubit>(
      create: (context) => DocListCubit(),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                height: (spacing_8 * 20),
                decoration: BoxDecoration(
                  color: green_10,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(80.0),
                  ),
                ),
              ),
              Positioned(
                left: spacing_16,
                bottom: spacing_8,
                child: Text(
                  'Documents',
                  style: TextStyle(fontSize: spacing_24, color: white_60),
                ),
              ),
              Positioned(
                bottom: screenOrientation == Orientation.portrait
                    ? -spacing_40
                    : -spacing_32,
                right: spacing_16,
                child: SvgPicture.asset(
                  svgFilePath,
                  height: getXPercentScreenHeight(
                    screenOrientation == Orientation.portrait ? 16 : 32,
                    screenHeight,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: spacing_8,
              horizontal: spacing_16,
            ),
            child: Row(
              children: const <Widget>[
                DocListOptions(),
              ],
            ),
          ),
          DocTypeList(),
        ],
      ),
    );
  }
}
