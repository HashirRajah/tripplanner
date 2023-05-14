import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tripplanner/models/document_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ImageTile extends StatelessWidget {
  final DocumentModel doc;
  //
  const ImageTile({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      color: colorFromHexCode('#0d678c'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        leading: Icon(
          Icons.image,
          color: white_60,
        ),
        title: Text(
          doc.documentName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: white_60,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () async {
            var status = await Permission.manageExternalStorage.status;
            //
            if (!status.isGranted) {
              await Permission.manageExternalStorage.request();
            }
            //
            await OpenFile.open(doc.documentPath);
          },
          icon: Icon(
            Icons.arrow_forward_outlined,
            size: Theme.of(context).textTheme.headlineSmall?.fontSize,
            color: white_60,
          ),
        ),
      ),
    );
  }
}
