import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/business_logic/blocs/dosuments_list_bloc/documents_list_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/document_model.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_app_bar.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/image_tile.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/pdf_tile.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/pick_file_buttons.dart';
import 'package:tripplanner/services/app_dir.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DocScreen extends StatelessWidget {
  final String svgFilePath = 'assets/svgs/no_docs.svg';
  final String title;
  final String path;
  final PickFileButtons pickFileButtons = PickFileButtons();
  final List<DocumentModel> testList = [];
  //
  DocScreen({super.key, required this.title, required this.path});

  @override
  Widget build(BuildContext context) {
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    //
    double screenHeight = getScreenHeight(context);
    String dirPath =
        '${AppDirectoryProvider.appDir}/trips/$tripId/documents/$title/';
    //
    return BlocProvider<DocumentsListBloc>(
      create: (context) => DocumentsListBloc(dirPath)..add(LoadDocumentList()),
      child: Scaffold(
        backgroundColor: tripCardColor,
        body: CustomScrollView(
          slivers: <Widget>[
            DocSliverAppBar(title: title),
            SliverPadding(
              padding: const EdgeInsets.all(spacing_16),
              sliver: testList.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            SvgPicture.asset(
                              svgFilePath,
                              height: getXPercentScreenHeight(30, screenHeight),
                            ),
                            Text(
                              'No documents',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: green_10,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (testList[index].documentExtension == 'pdf') {
                            return PDFTile(doc: testList[index]);
                          } else {
                            return ImageTile(doc: testList[index]);
                          }
                        },
                        childCount: testList.length,
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          spacing: spacing_8,
          spaceBetweenChildren: spacing_16,
          overlayColor: Colors.black,
          overlayOpacity: 0.6,
          children: <SpeedDialChild>[
            SpeedDialChild(
              child: Icon(
                Icons.card_travel_outlined,
                color: green_10,
              ),
              label: 'Use from other Trips',
              backgroundColor: searchBarColor,
              labelBackgroundColor: docTileColor,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: green_10,
              ),
            ),
            pickFileButtons.pickPDFButton(),
            pickFileButtons.uploadImageButton(context),
          ],
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
