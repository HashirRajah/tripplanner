import 'package:flutter/material.dart';
import 'package:tripplanner/services/firestore_services/personal_notes_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:quickalert/quickalert.dart';

class DeletePersonalNote extends StatelessWidget {
  final PersonalNotesCRUD personalNotesCRUD;

  const DeletePersonalNote({super.key, required this.personalNotesCRUD});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -1.0,
      top: -1.0,
      child: Container(
        decoration: BoxDecoration(
          color: searchBarColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: IconButton(
          highlightColor: errorColor,
          splashColor: errorColor.withOpacity(0.5),
          onPressed: () async {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.confirm,
              text: 'Delete note permanently',
              confirmBtnColor: errorColor,
              customAsset: 'assets/gifs/bin.gif',
              onConfirmBtnTap: () async {
                if (context.mounted) {
                  Navigator.pop(context);
                }
                //
                dynamic result = await personalNotesCRUD.deleteNote();
                //
                if (result != null) {
                  debugPrint(result);
                }
              },
            );
            //
          },
          icon: Icon(
            Icons.delete_forever_outlined,
            color: errorColor,
          ),
        ),
      ),
    );
  }
}
