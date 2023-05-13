import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/document_model.dart';
import 'package:tripplanner/services/doc_list_services.dart';

part 'documents_list_event.dart';
part 'documents_list_state.dart';

class DocumentsListBloc extends Bloc<DocumentsListEvent, DocumentsListState> {
  final DocListService _docListService = DocListService();
  final String dirPath;
  List<DocumentModel> _cachedDocuments = [];
  //
  DocumentsListBloc(this.dirPath) : super(DocumentsListInitial()) {
    on<LoadDocumentList>((event, emit) {
      //
      final List<DocumentModel> docs = _docListService.getDocuments(dirPath);
      //
      _cachedDocuments = docs;
      //
      emit(DocumentsListLoaded(documents: docs));
    });
    //
    on<SearchDocumentList>((event, emit) {
      //
      final List<DocumentModel> docs = event.query == ''
          ? _cachedDocuments
          : _cachedDocuments.where((DocumentModel doc) {
              return doc.documentName
                  .toLowerCase()
                  .contains(event.query.toLowerCase());
            }).toList();
      //
      emit(DocumentsListLoaded(documents: docs));
    });
    //
  }
}
