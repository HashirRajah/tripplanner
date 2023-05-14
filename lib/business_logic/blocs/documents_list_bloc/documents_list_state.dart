part of 'documents_list_bloc.dart';

abstract class DocumentsListState extends Equatable {}

class DocumentsListInitial extends DocumentsListState {
  @override
  List<Object?> get props => [];
}

class DocumentsListLoaded extends DocumentsListState {
  final List<DocumentModel> documents;

  DocumentsListLoaded({required this.documents});

  @override
  List<Object?> get props => [documents];
}
