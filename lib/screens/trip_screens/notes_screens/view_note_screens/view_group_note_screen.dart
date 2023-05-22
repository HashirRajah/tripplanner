import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:tripplanner/business_logic/cubits/group_note_cubit/group_note_cubit.dart';
import 'package:tripplanner/screens/trip_screens/notes_screens/view_note_screens/view_note_field.dart';
import 'package:tripplanner/services/firestore_services/group_notes_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ViewGroupNote extends StatelessWidget {
  final GroupNotesCRUD groupNotesCRUD;
  //
  const ViewGroupNote({
    super.key,
    required this.groupNotesCRUD,
  });
  //
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupNoteCubit>(
      create: (context) => GroupNoteCubit(groupNotesCRUD),
      child: Scaffold(
        backgroundColor: docTileColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0.0,
          centerTitle: true,
          title: BlocBuilder<GroupNoteCubit, GroupNoteState>(
            builder: (context, state) {
              String title = 'Loading...';
              //
              if (state is GroupNoteLoaded) {
                title = state.note.title;
              }
              //
              return Text(title);
            },
          ),
          systemOverlayStyle: darkOverlayStyle,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(spacing_24),
            child: Center(
              child: BlocBuilder<GroupNoteCubit, GroupNoteState>(
                builder: (context, state) {
                  QuillController controller;
                  //
                  if (state is GroupNoteLoaded) {
                    var body = jsonDecode(state.note.body);
                    //
                    controller = QuillController(
                      document: Document.fromJson(body),
                      selection: const TextSelection.collapsed(offset: 0),
                    );
                  } else {
                    controller = QuillController.basic();
                  }
                  //
                  return ViewNoteField(
                    quillController: controller,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
