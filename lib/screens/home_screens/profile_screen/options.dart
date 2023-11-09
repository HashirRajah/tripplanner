import 'package:flutter/material.dart';
import 'package:tripplanner/screens/home_screens/connection_screens/connections_screen.dart';
import 'package:tripplanner/screens/preferences_screens/add_preferences_screen.dart';
import 'package:tripplanner/screens/preferences_screens/preferences_screen.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/profile_option_tile.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spacing_16),
      decoration: BoxDecoration(
        color: docTileColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: const <Widget>[
          ProfileOptionTile(
            text: 'Preferences',
            icon: Icons.face_outlined,
            screen: PreferencesScreen(),
          ),
          Divider(),
          ProfileOptionTile(
            text: 'Connections',
            icon: Icons.people_alt_outlined,
            screen: ConnectionsScreen(),
          ),
        ],
      ),
    );
  }
}
