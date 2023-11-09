import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripplanner/business_logic/cubits/add_preferences_cubit/add_preferences_cubit.dart';
import 'package:tripplanner/business_logic/cubits/additionsl_user_info_cubit/additional_user_info_cubit.dart';
import 'package:tripplanner/business_logic/cubits/root_cubit/root_cubit.dart';
import 'package:tripplanner/models/country_model.dart';
import 'package:tripplanner/screens/additional_user_info_screens/info_field.dart';
import 'package:tripplanner/screens/preferences_screens/add_preferences_screen.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/google_maps_services/geocode_api.dart';
import 'package:tripplanner/services/shared_preferences_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/shared/widgets/message_dialog.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class AdditionalUserInfoScreen extends StatefulWidget {
  const AdditionalUserInfoScreen({super.key});

  @override
  State<AdditionalUserInfoScreen> createState() =>
      _AdditionalUserInfoScreenState();
}

class _AdditionalUserInfoScreenState extends State<AdditionalUserInfoScreen>
    with SingleTickerProviderStateMixin {
  late final UsersCRUD usersCRUD;
  bool loading = true;
  bool error = false;
  bool processing = false;
  final SharedPreferences prefs = SharedPreferencesService.prefs;
  //
  final String successMessage = 'Info saved';
  final String successLottieFilePath = 'assets/lottie_files/success.json';
  //
  late AnimationController controller;
  final GeocodeAPI geocodeAPI = GeocodeAPI();
  //
  Location location = Location();
  late LocationData currentLocation;
  late LatLng currentLatLng;
  bool _hasPermission = false;

  //
  @override
  void initState() {
    super.initState();
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    controller = AnimationController(vsync: this);
    //
    _checkServiceAndPermissions();
    // add listener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider<AddPreferencesCubit>(
                create: (context) => AddPreferencesCubit(),
                child: const AddPreferencesScreen(),
              );
            },
          ),
        );
        // Navigator.pop(context);
        // BlocProvider.of<RootCubit>(context).emit(RootState());
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
  Future<void> _checkServiceAndPermissions() async {
    //
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    //
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          loading = false;
          _hasPermission = false;
        });
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          loading = false;
          _hasPermission = false;
        });
        return;
      }
    }
    //
    if (!_hasPermission) {
      setState(() {
        _hasPermission = true;
      });
    }
    //
    await getCurrentLocation();
  }

  //
  Future<void> getCurrentLocation() async {
    //
    if (!loading) {
      setState(() {
        loading = true;
      });
    }
    //
    currentLocation = await location.getLocation();
    //
    currentLatLng =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //
    dynamic result = await geocodeAPI.getCountryInfo(currentLatLng);
    // CountryModel(
    //   name: 'Mauritius',
    //   code: 'MU',
    // ); //
    //
    if (result == null) {
      error = true;
    } else {
      //
      if (context.mounted) {
        BlocProvider.of<AdditionalUserInfoCubit>(context).residency = result;
        BlocProvider.of<AdditionalUserInfoCubit>(context).citizenship = result;
      }
    }
    //
    loading = false;
    //
    setState(() {});
  }

  //
  Future<void> getInfo() async {
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
          action: getInfo,
        ),
      );
    }
    //
    Orientation screenOrientation = getScreenOrientation(context);
    //
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: spacing_24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Almost there',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              addVerticalSpace(spacing_8),
              Center(
                child: Text(
                  'Confirm residency and citizenship',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
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
              const InfoField(
                type: 'residency',
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
              const InfoField(
                type: 'citizenship',
              ),
            ],
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
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(spacing_24),
        child: ElevatedButtonWrapper(
          childWidget: ElevatedButton.icon(
            onPressed: () async {
              //
              CountryModel? residency =
                  BlocProvider.of<AdditionalUserInfoCubit>(context).residency;
              CountryModel? citizenship =
                  BlocProvider.of<AdditionalUserInfoCubit>(context).citizenship;
              //
              if (residency != null && citizenship != null) {
                setState(() {
                  processing = true;
                });
                dynamic result =
                    await usersCRUD.addAdditionalInfo(residency, citizenship);
                //
                await prefs.setBool('user-additional-Info', true);
                setState(() {
                  processing = false;
                });

                if (context.mounted) {
                  messageDialog(context, successMessage, successLottieFilePath,
                      controller, false);
                }
              } else {
                Fluttertoast.showToast(
                  msg: "Select residency and citizenship",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: green_10.withOpacity(0.5),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            icon: const Icon(Icons.arrow_forward),
            label: processing
                ? SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      color: white_60,
                      strokeWidth: 2.0,
                    ),
                  )
                : const Text('Next'),
          ),
        ),
      ),
      body: buildBody(),
    );
  }
}
