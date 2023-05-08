import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tripplanner/models/doc_tile_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class DocTile extends StatelessWidget {
  final DocTileModel docTileModel;
  //
  const DocTile({super.key, required this.docTileModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      color: docTileColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        leading: FaIcon(
          docTileModel.iconData,
          color: green_10,
        ),
        title: Text(
          docTileModel.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => docTileModel.navigationScreen,
              ),
            );
          },
          icon: Icon(
            Icons.arrow_forward_outlined,
            size: Theme.of(context).textTheme.headlineSmall?.fontSize,
            color: green_10,
          ),
        ),
      ),
    );
  }
}
