import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class Profile extends StatelessWidget {
  //
  final String defaultAvatarImageUrl =
      'https://stickercommunity.com/uploads/main/11-01-2022-11-15-50fldsc-sticker5.webp';
  //
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    //
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: spacing_64,
          backgroundColor: green_10,
          backgroundImage:
              NetworkImage(user!.photoURL ?? defaultAvatarImageUrl),
        ),
        addVerticalSpace(spacing_16),
        Text(
          user.displayName!,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: green_10),
        ),
        addVerticalSpace(spacing_8),
        Text(
          user.email!,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.w600, color: green_10),
        ),
      ],
    );
  }
}
