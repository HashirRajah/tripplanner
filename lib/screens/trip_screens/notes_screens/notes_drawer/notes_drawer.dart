import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class NotesDrawer extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/notes_categories.svg';
  //
  const NotesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: green_10,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            padding: const EdgeInsets.all(0.0),
            child: SvgPicture.asset(svgFilePath),
          ),
          ListTile(
            iconColor: white_60,
            textColor: white_60,
            leading: Icon(Icons.person),
            title: Text(
              'Personal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          ListTile(
            iconColor: white_60,
            textColor: white_60,
            leading: Icon(Icons.group),
            title: Text('Group'),
          ),
        ],
      ),
    );
  }
}
