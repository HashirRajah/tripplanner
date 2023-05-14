part of 'documents_list_bloc.dart';

abstract class DocumentsListEvent {}

class LoadDocumentList extends DocumentsListEvent {}

class SearchDocumentList extends DocumentsListEvent {
  final String query;

  SearchDocumentList({required this.query});
}
