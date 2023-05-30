import 'package:flutter/material.dart';
import 'package:tripplanner/models/document_model.dart';
import 'package:tripplanner/screens/trip_screens/documents_screens/rename_doc.dart';
import 'package:tripplanner/services/save_documents_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:quickalert/quickalert.dart';

class DocumentExpandedOptions extends StatelessWidget {
  final DocumentModel doc;
  final Function onDone;

  const DocumentExpandedOptions({
    super.key,
    required this.doc,
    required this.onDone,
  });

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
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  enableDrag: false,
                  clipBehavior: Clip.hardEdge,
                  backgroundColor: docTileColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  builder: (context) {
                    return RenameDoc(
                      filePath: doc.documentPath,
                      onDone: onDone,
                      docType: doc.documentExtension == '.pdf'
                          ? 'Document'
                          : 'Image',
                    );
                  },
                );
              },
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
                    //
                    dynamic result = await SaveDocumentsService()
                        .deleteDoc(doc.documentPath);
                    //
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                    //
                    if (result == null) {
                      onDone();
                    } else {}
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
