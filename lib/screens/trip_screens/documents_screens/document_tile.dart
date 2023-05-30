import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:tripplanner/models/document_model.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/document_expanded_options.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentTile extends StatefulWidget {
  final DocumentModel doc;
  //
  const DocumentTile({super.key, required this.doc});

  @override
  State<DocumentTile> createState() => _DocumentTileState();
}

class _DocumentTileState extends State<DocumentTile> {
  //
  //
  bool displayExpandedOptions = false;
  //
  void _displayOptions() {
    setState(() {
      displayExpandedOptions = true;
    });
  }

  //
  void hideOptions() {
    setState(() {
      displayExpandedOptions = false;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //
        if (displayExpandedOptions) {
          hideOptions();
          //
          return;
        }
        //
        var status = await Permission.manageExternalStorage.status;
        //
        if (!status.isGranted) {
          await Permission.manageExternalStorage.request();
        }
        //
        await OpenFile.open(widget.doc.documentPath);
      },
      onLongPress: () => _displayOptions(),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: spacing_8),
            child: Card(
              elevation: 3.0,
              color: docTileColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListTile(
                leading: Icon(
                  widget.doc.documentExtension == '.pdf'
                      ? Icons.picture_as_pdf
                      : Icons.image,
                  color: green_10,
                ),
                title: Text(
                  widget.doc.documentName,
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
          displayExpandedOptions
              ? DocumentExpandedOptions(id: '')
              : Container(),
        ],
      ),
    );
  }
}
