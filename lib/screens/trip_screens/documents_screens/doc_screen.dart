import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/documents_list_bloc/documents_list_bloc.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_app_bar.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_list.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/pick_file_buttons.dart';
import 'package:tripplanner/services/app_dir.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DocScreen extends StatefulWidget {
  final String title;
  final String path;
  final bool shared;
  //
  const DocScreen({
    super.key,
    required this.title,
    required this.path,
    required this.shared,
  });

  @override
  State<DocScreen> createState() => _DocScreenState();
}

class _DocScreenState extends State<DocScreen>
    with SingleTickerProviderStateMixin {
  //
  late AnimationController controller;
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  //
  @override
  void initState() {
    super.initState();
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    controller.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    String tripId = BlocProvider.of<TripIdCubit>(context).tripId;
    String dirPath;
    //
    if (widget.shared) {
      dirPath =
          '${AppDirectoryProvider.appDir.path}/trips/shared/documents/${widget.path}/';
    } else {
      dirPath =
          '${AppDirectoryProvider.appDir.path}/trips/$tripId/documents/${widget.path}/';
    }

    //
    final PickFileButtons pickFileButtons = PickFileButtons(
      newFilePath: dirPath,
      controller: controller,
      context: context,
    );
    //
    return BlocProvider<DocumentsListBloc>(
      create: (context) => DocumentsListBloc(dirPath)..add(LoadDocumentList()),
      child: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: Scaffold(
          backgroundColor: tripCardColor,
          body: CustomScrollView(
            slivers: <Widget>[
              DocSliverAppBar(
                title: widget.title,
                controller: textEditingController,
                focusNode: focusNode,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(spacing_16),
                sliver: DocList(
                  dirPath: dirPath,
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
              pickFileButtons.pickPDFButton(),
              pickFileButtons.uploadImageButton(),
            ],
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
