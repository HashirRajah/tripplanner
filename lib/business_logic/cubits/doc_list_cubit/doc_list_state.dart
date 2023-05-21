part of 'doc_list_cubit.dart';

class DocListState extends Equatable {
  final bool shared;

  const DocListState({required this.shared});

  @override
  List<Object> get props => [shared];
}
