part of 'documents_list_bloc.dart';

abstract class DocumentsListState extends Equatable {
  const DocumentsListState();

  @override
  List<Object> get props => [];
}

class DocumentsListInitial extends DocumentsListState {}

class DocumentsListLoaded extends DocumentsListState {
  final List<DocumentModel> documents;

  const DocumentsListLoaded({required this.documents});
}
