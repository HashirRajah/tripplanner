import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reload_state.dart';

class ReloadCubit extends Cubit<ReloadState> {
  ReloadCubit() : super(ReloadState());

  void reload() => emit(ReloadState());
}
