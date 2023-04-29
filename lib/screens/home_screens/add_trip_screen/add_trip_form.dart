import 'package:flutter/material.dart';
import 'package:tripplanner/screens/sign_up_screen/sign_up_screen.dart';
import 'package:tripplanner/services/auth_services.dart';
import 'package:tripplanner/services/validation_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/destinations_tags.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';
import 'package:tripplanner/shared/widgets/facebook_sign_in.dart';
import 'package:tripplanner/shared/widgets/google_sign_in.dart';
import 'package:tripplanner/shared/widgets/link_button.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/shared/widgets/or_divider.dart';
import 'package:tripplanner/shared/widgets/question_action.dart';
import 'package:tripplanner/shared/widgets/search.dart';
import 'package:tripplanner/shared/widgets/show_password.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddTripForm extends StatefulWidget {
  //
  final String title;
  //
  const AddTripForm({super.key, required this.title});

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  State<AddTripForm> createState() => _AddTripFormState();
}

class _AddTripFormState extends State<AddTripForm>
    with SingleTickerProviderStateMixin {
  // form key
  final _formkey = GlobalKey<FormState>();
  final _titleFormFieldKey = GlobalKey<FormFieldState>();
  final _passwordFormFieldKey = GlobalKey<FormFieldState>();
  //
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _budgetFocusNode = FocusNode();
  //
  final ValidationService validationService = ValidationService();
  //
  String tripTitle = '';
  String password = '';
  bool showPassword = false;
  //
  final AuthService _auth = AuthService();
  bool processing = false;
  //
  final String successMessage = 'Trip Added';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    //
    super.initState();
    //
    _titleFocusNode.addListener(() =>
        validateTextFormFieldOnFocusLost(_titleFormFieldKey, _titleFocusNode));
    _budgetFocusNode.addListener(() => validateTextFormFieldOnFocusLost(
        _passwordFormFieldKey, _budgetFocusNode));
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  //
  @override
  void dispose() {
    //
    super.dispose();
    // dispose focus nodes
    _titleFocusNode.dispose();
    _budgetFocusNode.dispose();
    controller.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: _titleFormFieldKey,
            initialValue: tripTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) => setState(() => tripTitle = value),
            onEditingComplete: () => _titleFocusNode.unfocus(),
            validator: (value) {},
            decoration: InputDecoration(
              filled: true,
              fillColor: searchBarColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: const Icon(Icons.title_outlined),
              hintText: 'Title',
            ),
            focusNode: _titleFocusNode,
            maxLength: 23,
          ),
          addVerticalSpace(spacing_16),
          Container(
            padding: const EdgeInsets.only(
              left: spacing_16,
              right: spacing_16,
              bottom: spacing_16,
            ),
            decoration: BoxDecoration(
              color: searchBarColor,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(),
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  minVerticalPadding: spacing_8,
                  horizontalTitleGap: 0.0,
                  // minLeadingWidth: spacing_16,
                  leading: Icon(
                    Icons.add_location_alt_sharp,
                    color: green_10,
                  ),
                  title: Text(
                    'Destinations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: green_10,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: Search());
                    },
                    icon: Icon(
                      Icons.add,
                      color: green_10,
                    ),
                  ),
                ),
                SizedBox(
                  height: spacing_40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return const DestinationTag(
                        destination: 'Germany',
                        flagUrl:
                            'https://www.countryflagicons.com/FLAT/64/DE.png',
                      );
                    },
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
          addVerticalSpace(spacing_16),
          GestureDetector(
            onTap: () async {
              showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(3000),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(spacing_16),
              decoration: BoxDecoration(
                color: searchBarColor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: green_30,
                      ),
                      addHorizontalSpace(spacing_8),
                      Text(
                        '01/01/2000',
                        style: dateTextStyle,
                      ),
                    ],
                  ),
                  addHorizontalSpace(spacing_8),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: green_10,
                  ),
                  addHorizontalSpace(spacing_8),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: green_30,
                      ),
                      addHorizontalSpace(spacing_8),
                      Text(
                        '01/01/2000',
                        style: dateTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpace(spacing_16),
          TextFormField(
            initialValue: null,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (value) => setState(() => tripTitle = value),
            onEditingComplete: () => _budgetFocusNode.unfocus(),
            decoration: InputDecoration(
              filled: true,
              fillColor: searchBarColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: const Icon(Icons.attach_money_outlined),
              hintText: 'Budget (Optional)',
            ),
            focusNode: _budgetFocusNode,
            keyboardType: TextInputType.number,
            maxLength: 7,
          ),
          addVerticalSpace(spacing_16),
          ElevatedButtonWrapper(
            childWidget: ElevatedButton(
              onPressed: () {},
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
