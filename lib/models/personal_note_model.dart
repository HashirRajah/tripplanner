import 'package:intl/intl.dart';
import 'package:tripplanner/models/note_model.dart';

class PersonalNoteModel extends NoteModel {
  final String? noteId;
  final String title;
  final String body;
  final bool important;
  final String modifiedAt;
  //
  final DateFormat dateFormat = DateFormat('EEEE MMMM d, yyyy H:m');
  //
  PersonalNoteModel({
    this.noteId,
    required this.title,
    required this.body,
    required this.important,
    required this.modifiedAt,
  });

  String getModifiedAtFormatted() {
    DateTime modifiedAtFormatted = DateTime.parse(modifiedAt);
    //
    return dateFormat.format(modifiedAtFormatted);
  }

  Map<String, dynamic> getPersonalNoteMap() {
    return {
      'title': title,
      'body': body,
      'important': important,
      'modified_at': modifiedAt,
    };
  }
}
