import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tripplanner/models/country_model.dart';

part 'additional_user_info_state.dart';

class AdditionalUserInfoCubit extends Cubit<AdditionalUserInfoState> {
  CountryModel? residency;
  CountryModel? citizenship;
  //
  AdditionalUserInfoCubit() : super(AdditionalUserInfoState());
  //
  void setResidency(CountryModel country) {
    residency = country;
  }

  //
  void setCitizenship(CountryModel country) {
    citizenship = country;
  }
}
