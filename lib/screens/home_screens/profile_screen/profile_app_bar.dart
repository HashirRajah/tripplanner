import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tripplanner/services/auth_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

PreferredSizeWidget profileAppBar(BuildContext context) {
  final AuthService authService = AuthService();
  //
  return AppBar(
    systemOverlayStyle: darkOverlayStyle,
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.edit,
        color: green_10,
      ),
    ),
    actions: [
      IconButton(
        tooltip: 'Logout',
        onPressed: () {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.confirm,
            confirmBtnColor: green_10,
            confirmBtnText: 'Logout',
            onConfirmBtnTap: () async {
              await authService.signOut();
              //
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          );
        },
        icon: Icon(
          Icons.logout_outlined,
          color: green_10,
        ),
      )
    ],
  );
}
