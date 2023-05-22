import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/documents_list_bloc/documents_list_bloc.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/doc_user_feedback.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/document_tile.dart';
import 'package:tripplanner/services/doc_list_services.dart';

class DocList extends StatelessWidget {
  final String dirPath;
  final String svgFilePath = 'assets/svgs/no_docs.svg';
  final String errorSvgFilePath = 'assets/svgs/error.svg';
  //
  const DocList({super.key, required this.dirPath});

  @override
  Widget build(BuildContext context) {
    //
    return StreamBuilder<FileSystemEvent>(
      stream: DocListService(dirPath: dirPath).docStream,
      builder: (context, snapshot) {
        // reload list if doc added or deleted
        if (snapshot.hasData) {
          BlocProvider.of<DocumentsListBloc>(context).add(LoadDocumentList());
        }
        //
        return BlocBuilder<DocumentsListBloc, DocumentsListState>(
          builder: (context, state) {
            //
            if (state is DocumentsListInitial) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            //
            if (state is DocumentsListLoaded) {
              if (state.documents.isEmpty) {
                return SliverToBoxAdapter(
                  child: DocListFeedback(
                    message: 'No documents',
                    svgFilePath: svgFilePath,
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return DocumentTile(
                        doc: state.documents[index],
                      );
                    },
                    childCount: state.documents.length,
                  ),
                );
              }
            }
            //
            return SliverToBoxAdapter(
              child: DocListFeedback(
                message: 'An error ocurred!',
                svgFilePath: errorSvgFilePath,
              ),
            );
          },
        );
      },
    );
  }
}
