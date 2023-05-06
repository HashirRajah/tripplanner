import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_index_state.dart';

class PageIndexCubit extends Cubit<PageIndexState> {
  PageIndexCubit() : super(const PageIndexState(pageIndex: 0));

  // change page index
  void changePageIndex(int index) => emit(PageIndexState(pageIndex: index));
}
