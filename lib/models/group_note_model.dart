import 'package:intl/intl.dart';
import 'package:tripplanner/models/note_model.dart';

class GroupNoteModel extends NoteModel {
  final String? noteId;
  final String title;
  final Map<String, dynamic> body;
  final String modifiedAt;
  final String owner;
  final List<String> staredBy;
  //
  final DateFormat dateFormat = DateFormat('yyyy-MMMMEEEEd Hm');
  //
  GroupNoteModel({
    this.noteId,
    required this.title,
    required this.body,
    required this.modifiedAt,
    required this.owner,
    required this.staredBy,
  });

  String getModifiedAtFormatted() {
    DateTime modifiedAtFormatted = DateTime.parse(modifiedAt);
    //
    return dateFormat.format(modifiedAtFormatted);
  }

  Map<String, dynamic> getGroupNoteMap() {
    return {
      'title': title,
      'body': body,
      'modified_at': modifiedAt,
      'owner': owner,
      'stared_by': staredBy,
    };
  }
}
