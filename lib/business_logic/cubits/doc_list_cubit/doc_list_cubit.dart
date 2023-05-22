import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'doc_list_state.dart';

class DocListCubit extends Cubit<DocListState> {
  DocListCubit() : super(const DocListState(shared: true));

  //
  void toggleState() => emit(DocListState(shared: !state.shared));
}
