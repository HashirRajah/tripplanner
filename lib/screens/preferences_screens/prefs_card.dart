import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tripplanner/models/category_model.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/pixaby_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/error_snackbar.dart';

class PrefsCard extends StatefulWidget {
  final CategoryModel categoryModel;
  final UsersCRUD usersCRUD;
  final Function reload;
  //
  const PrefsCard({
    super.key,
    required this.categoryModel,
    required this.usersCRUD,
    required this.reload,
  });

  @override
  State<PrefsCard> createState() => _PrefsCardState();
}

class _PrefsCardState extends State<PrefsCard> {
  bool? isSelected = false;
  String defaultImageUrl =
      'https://images.unsplash.com/photo-1527998257557-0c18b22fa4cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=736&q=80';
  String imageUrl = '';
  final PixabyAPI pixabyAPI = PixabyAPI();
  //
  @override
  void initState() {
    super.initState();
    //
    getImage();
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  //
  Future<void> getImage() async {
    dynamic result = await pixabyAPI.getImage(widget.categoryModel.title);
    //
    if (result != null) {
      setState(() {
        imageUrl = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(spacing_8),
          margin: const EdgeInsets.all(spacing_8),
          width: (spacing_8 * 20),
          height: (spacing_8 * 25),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(
                imageUrl == '' ? defaultImageUrl : imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(spacing_16),
          margin: const EdgeInsets.all(spacing_8),
          width: (spacing_8 * 20),
          height: (spacing_8 * 25),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.categoryModel.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: white_60,
                    ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(spacing_8),
          margin: const EdgeInsets.all(spacing_8),
          width: (spacing_8 * 20),
          height: (spacing_8 * 25),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: searchBarColor.withOpacity(0.7),
                    child: IconButton(
                      onPressed: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          text: 'Remove Preference',
                          confirmBtnColor: errorColor,
                          customAsset: 'assets/gifs/bin.gif',
                          onConfirmBtnTap: () async {
                            if (context.mounted) {
                              Navigator.pop(context);
                              //
                              Fluttertoast.showToast(
                                msg: "Removing Preference",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: green_10.withOpacity(0.5),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              //
                              dynamic result = await widget.usersCRUD
                                  .removePreference(widget.categoryModel);
                              //
                              if (result != null) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(errorSnackBar(
                                    context,
                                    'Cannot Remove Preference',
                                    result,
                                  ));
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Preference Removed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: green_10.withOpacity(0.5),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                //
                                await widget.reload();
                              }
                            }
                            //
                          },
                        );
                      },
                      icon: Icon(
                        Icons.remove,
                        color: errorColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
