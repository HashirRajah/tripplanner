import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripplanner/models/category_model.dart';
import 'package:tripplanner/screens/preferences_screens/prefs_card.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/empty_list.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final String title = 'Preferences';
  final String svgFilePath = 'assets/svgs/empty.svg';
  final String notFoundSvgFilePath = 'assets/svgs/user_not_found.svg';
  late final UsersCRUD usersCRUD;
  final LocalService localService = LocalService();
  List<CategoryModel> categories = [];
  bool loading = true;
  bool error = false;
  //
  @override
  void initState() {
    super.initState();
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    getPreferences();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> getPreferences() async {
    dynamic result = await usersCRUD.getAllPreferences();
    //
    if (result != null) {
      //
      for (int id in result) {
        dynamic cat = await localService.getCategory(id);
        //
        if (cat != null) {
          categories.add(cat);
        }
      }
      //
      error = false;
    } else {
      error = true;
    }
    //
    loading = false;
    //
    setState(() {});
  }

  final SharedPreferences prefs = SharedPreferencesService.prefs;
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
          action: getPreferences,
        ),
      );
    }
    //
    if (categories.isEmpty) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: EmptyList(svgFilePath: svgFilePath, message: 'No preferences'),
      );
    }
    //
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(spacing_8),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenOrientation == Orientation.portrait ? 2 : 4,
            ),
            itemBuilder: (context, index) {
              return PrefsCard(
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
              await prefs.setBool('user-additional-Info', false);
            },
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
        ),
      ),
      body: buildBody(),
    );
  }
}
