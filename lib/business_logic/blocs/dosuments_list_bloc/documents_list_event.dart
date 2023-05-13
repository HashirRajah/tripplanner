part of 'documents_list_bloc.dart';

abstract class DocumentsListEvent extends Equatable {
  const DocumentsListEvent();

  @override
  List<Object> get props => [];
}

class LoadDocumentList extends DocumentsListEvent {}

class SearchDocumentList extends DocumentsListEvent {
  final String query;

  const SearchDocumentList({required this.query});
}
