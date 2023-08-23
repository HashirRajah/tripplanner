import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripplanner/business_logic/cubits/add_preferences_cubit/add_preferences_cubit.dart';
import 'package:tripplanner/business_logic/cubits/root_cubit/root_cubit.dart';
import 'package:tripplanner/models/category_model.dart';
import 'package:tripplanner/screens/preferences_screens/pref_tag.dart';
import 'package:tripplanner/screens/preferences_screens/preferences_card.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AddNewPreferencesScreen extends StatefulWidget {
  final Function reload;
  const AddNewPreferencesScreen({
    super.key,
    required this.reload,
  });

  @override
  State<AddNewPreferencesScreen> createState() =>
      _AddNewPreferencesScreenState();
}

class _AddNewPreferencesScreenState extends State<AddNewPreferencesScreen>
    with SingleTickerProviderStateMixin {
  final String title = 'Preferences';
  final String svgFilePath = 'assets/svgs/freinds.svg';
  final String notFoundSvgFilePath = 'assets/svgs/user_not_found.svg';
  late final UsersCRUD usersCRUD;
  final LocalService localService = LocalService();
  List<CategoryModel> categories = [];
  bool loading = true;
  bool error = false;
  bool processing = false;
  final SharedPreferences prefs = SharedPreferencesService.prefs;
  List<int> userPreferences = [];
  //
  final String successMessage = 'Preferences saved';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  //
  @override
  void initState() {
    super.initState();
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    getCategories();
    //
    controller = AnimationController(vsync: this);
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        Navigator.pop(context);
        widget.reload();
        controller.reset();
      }
    });
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> getCategories() async {
    userPreferences = await usersCRUD.getAllPreferences();
    dynamic result = await localService.getFilteredCategories(userPreferences);
    //
    if (result != null) {
      categories = result;
      error = false;
    } else {
      error = true;
    }
    //
    loading = false;
    //
    setState(() {});
  }

  //
  Widget buildBody() {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    //
    if (error) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ErrorStateWidget(
          action: getCategories,
        ),
      );
    }
    //
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Text(
                'Add new preferences',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              addVerticalSpace(spacing_8),
              addVerticalSpace(spacing_8),
              BlocBuilder<AddPreferencesCubit, AddPreferencesState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: spacing_16),
                    child: SizedBox(
                      height: spacing_48,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return PrefTag(
                            pref: BlocProvider.of<AddPreferencesCubit>(context)
                                .categories[index]
                                .title,
                          );
                        },
                        itemCount: BlocProvider.of<AddPreferencesCubit>(context)
                            .categories
                            .length,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(spacing_8),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenOrientation == Orientation.portrait ? 2 : 4,
            ),
            itemBuilder: (context, index) {
              return PreferencesCard(
                categoryModel: categories[index],
              );
            },
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: darkOverlayStyle,
        title: Text(title),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: green_10,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(spacing_24),
        child: ElevatedButtonWrapper(
          childWidget: ElevatedButton.icon(
            onPressed: () async {
              //
              if (BlocProvider.of<AddPreferencesCubit>(context)
                  .categories
                  .isEmpty) {
                Fluttertoast.showToast(
                  msg: "No preference added!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: green_10.withOpacity(0.5),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else {
                setState(() {
                  processing = true;
                });
                dynamic result = await usersCRUD.addPreferences(
                    BlocProvider.of<AddPreferencesCubit>(context).categoryIds,
                    BlocProvider.of<AddPreferencesCubit>(context).categories);

                setState(() {
                  processing = false;
                });
                //
                if (result == null) {
                  //
                  if (context.mounted) {
                    messageDialog(context, successMessage,
                        successLottieFilePath, controller, false);
                  }
                }
              }
            },
            icon: const Icon(Icons.done),
            label: processing
                ? SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      color: white_60,
                      strokeWidth: 2.0,
                    ),
                  )
                : const Text('Save'),
          ),
        ),
      ),
      body: buildBody(),
    );
  }
}
