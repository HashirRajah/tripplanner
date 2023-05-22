import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:tripplanner/models/document_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentTile extends StatelessWidget {
  final DocumentModel doc;
  //
  const DocumentTile({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //
        var status = await Permission.manageExternalStorage.status;
        //
        if (!status.isGranted) {
          await Permission.manageExternalStorage.request();
        }
        //
        await OpenFile.open(doc.documentPath);
      },
      onLongPress: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: spacing_8),
        child: Card(
          elevation: 3.0,
          color: docTileColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            leading: Icon(
              doc.documentExtension == '.pdf'
                  ? Icons.picture_as_pdf
                  : Icons.image,
              color: green_10,
            ),
            title: Text(
              doc.documentName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: green_10,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(
              Icons.arrow_forward_outlined,
              size: Theme.of(context).textTheme.headlineSmall?.fontSize,
              color: green_10,
            ),
          ),
        ),
      ),
    );
  }
}
