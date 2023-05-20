import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tripplanner/business_logic/blocs/documents_list_bloc/documents_list_bloc.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DocSliverAppBar extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/folders.svg';
  final String title;
  final TextEditingController controller;
  final FocusNode focusNode;
  //
  const DocSliverAppBar({
    super.key,
    required this.title,
    required this.controller,
    required this.focusNode,
  });

  //
  void search(BuildContext context, String query) {
    BlocProvider.of<DocumentsListBloc>(context).add(
      SearchDocumentList(query: query),
    );
  }

  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return SliverAppBar(
      backgroundColor: green_10,
      pinned: true,
      floating: true,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(screenWidth / 2, 1),
          bottomRight: Radius.elliptical(screenWidth / 2, 1),
        ),
      ),
      expandedHeight: (spacing_8 * 30),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.info,
              confirmBtnColor: green_10,
              text: 'Only PDFs and Images can be added',
            );
          },
          icon: const Icon(Icons.info_outline),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: SvgPicture.asset(svgFilePath),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(spacing_96),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: spacing_32,
              width: double.infinity,
              decoration: BoxDecoration(
                color: tripCardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: spacing_24,
                top: spacing_24,
                right: spacing_24,
              ),
              child: SearchBar(
                controller: controller,
                focusNode: focusNode,
                hintText: title,
                search: search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
