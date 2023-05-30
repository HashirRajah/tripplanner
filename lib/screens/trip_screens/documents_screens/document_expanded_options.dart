import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:quickalert/quickalert.dart';

class DocumentExpandedOptions extends StatelessWidget {
  final String id;

  const DocumentExpandedOptions({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: spacing_8,
      top: spacing_8,
      child: Container(
        decoration: BoxDecoration(
          color: green_10,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Rename',
              highlightColor: green_10,
              splashColor: green_10.withOpacity(0.5),
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: white_60,
              ),
            ),
            IconButton(
              tooltip: 'Delete',
              highlightColor: errorColor,
              splashColor: errorColor.withOpacity(0.5),
              onPressed: () async {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  text: 'Delete document permanently',
                  confirmBtnColor: errorColor,
                  customAsset: 'assets/gifs/bin.gif',
                  onConfirmBtnTap: () async {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                    //
                  },
                );
                //
              },
              icon: Icon(
                Icons.delete_forever_outlined,
                color: errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
