import 'package:bloc/bloc.dart';
import 'package:tripplanner/models/category_model.dart';

part 'add_preferences_state.dart';

class AddPreferencesCubit extends Cubit<AddPreferencesState> {
  List<int> categoryIds = [];
  List<CategoryModel> categories = [];
  //
  AddPreferencesCubit() : super(AddPreferencesState());

  void addCategory(CategoryModel cat) {
    categoryIds.add(cat.id);
    categories.add(cat);
    emit(AddPreferencesState());
  }

  void removeCategory(CategoryModel cat) {
    categoryIds.remove(cat.id);
    categories.remove(cat);
    emit(AddPreferencesState());
  }
}
