import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/screens/additional_user_info_screens/info_field.dart';
import 'package:tripplanner/screens/home_screens/profile_screen/res_cit_field.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class EditProfileForm extends StatefulWidget {
  //
  final String title;
  //
  const EditProfileForm({super.key, required this.title});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _usernameFormFieldKey = GlobalKey<FormFieldState>();
  //
  final ValidationService validationService = ValidationService();
  late final UsersCRUD usersCRUD;
  late final String userId;
  //
  final FocusNode _usernameFocusNode = FocusNode();
  //
  bool processing = false;
  bool loading = true;
  String username = '';
  late String initialUsername;
  CountryModel? residency;
  CountryModel? citizenship;
  CountryModel? initialResidency;
  CountryModel? initialCitizenship;
  //
  final String successMessage = 'Profile Updated';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    _usernameFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _usernameFormFieldKey, _usernameFocusNode));
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.popUntil(context, (route) => route.isFirst);
        controller.reset();
      }
    });
    //
    fetchUserDetails();
  }

  //
  @override
  void dispose() {
    // dispose focus nodes
    controller.dispose();
    _usernameFocusNode.dispose();
    //
    super.dispose();
  }

  //
  Future<void> fetchUserDetails() async {
    dynamic result = await usersCRUD.getUsername();
    dynamic residencyResult = await usersCRUD.getResidencyFull();
    dynamic citizenshipResult = await usersCRUD.getCitizenshipFull();
    //
    if (result != null) {
      username = result;
      initialUsername = username;
    }
    if (residencyResult != null) {
      residency = residencyResult;
      initialResidency = residency;
    }
    if (citizenshipResult != null) {
      citizenship = citizenshipResult;
      initialCitizenship = citizenship;
    }
    //
    setState(() {
      loading = false;
    });
  }

  //
  Future<void> _updateProfile() async {
    //
    String errorTitle = 'Failed to update Profile';
    String errorMessage = '';
    // validate form
    bool validForm = _formkey.currentState!.validate();
    //
    if (validForm) {
      //
      setState(() => processing = true);
      //
      dynamic result;
      int changes = 0;
      if (username != initialUsername) {
        result = await usersCRUD.updateUsername(username);
        changes++;
      }
      //
      if (initialResidency != residency && residency != null) {
        result = await usersCRUD.addResidency(residency!);
        changes++;
      }
      //
      if (initialCitizenship != citizenship && citizenship != null) {
        result = await usersCRUD.addCitizenship(citizenship!);
        changes++;
      }
      //
      //
      setState(() => processing = false);
      //
      if (changes == 0) {
        Fluttertoast.showToast(
          msg: "No changes",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: green_10.withOpacity(0.5),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        if (result != null) {
          //
          errorMessage = result;
          //
          if (context.mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackBar(context, errorTitle, errorMessage));
          }
        } else if (result == null) {
          if (context.mounted) {
            messageDialog(context, successMessage, successLottieFilePath,
                controller, false);
          }
        }
      }
      // check if errors
    }
  }

  //
  void changeResidency(CountryModel country) {
    setState(() {
      residency = country;
    });
  }

  //
  void changeCitizenship(CountryModel country) {
    setState(() {
      citizenship = country;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  key: _usernameFormFieldKey,
                  initialValue: username,
                  onChanged: (value) => setState(() => username = value.trim()),
                  onEditingComplete: () => _usernameFocusNode.unfocus(),
                  validator: (value) =>
                      validationService.validateUsername(username),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: searchBarColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Username',
                  ),
                  keyboardType: TextInputType.name,
                  focusNode: _usernameFocusNode,
                ),
                addVerticalSpace(spacing_24),
                Text(
                  'Residency',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(spacing_8),
                ResidencyCitizenshipField(
                  country: residency!,
                  changeCountry: changeResidency,
                ),
                addVerticalSpace(spacing_16),
                Text(
                  'Citizenship',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(spacing_8),
                ResidencyCitizenshipField(
                  country: citizenship!,
                  changeCountry: changeCitizenship,
                ),
                addVerticalSpace(spacing_24),
                ElevatedButtonWrapper(
                  childWidget: ElevatedButton(
                    onPressed: () async => _updateProfile(),
                    child: ButtonChildProcessing(
                      processing: processing,
                      title: widget.title,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
