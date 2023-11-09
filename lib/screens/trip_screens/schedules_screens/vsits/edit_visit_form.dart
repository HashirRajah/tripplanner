import 'package:flutter/material.dart';
import 'package:tripplanner/shared/widgets/button_child_processing.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';

class EditVisitForm extends StatefulWidget {
  final Function edit;
  //
  const EditVisitForm({super.key, required this.edit});

  @override
  State<EditVisitForm> createState() => _EditVisitFormState();
}

class _EditVisitFormState extends State<EditVisitForm> {
  //
  bool processing = false;
  //
  @override
  Widget build(BuildContext context) {
    return ElevatedButtonWrapper(
      childWidget: ElevatedButton(
        onPressed: () async {
          setState(() {
            processing = true;
          });
          //
          await widget.edit();
          //
          setState(() {
            processing = false;
          });
        },
        child: ButtonChildProcessing(
          processing: processing,
          title: 'Save',
        ),
      ),
    );
  }
}
