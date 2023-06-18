import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';

class AddConnections extends StatelessWidget {
  final String title = 'Add';
  const AddConnections({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: darkOverlayStyle,
        title: Text(title),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: green_10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(spacing_24),
        child: Column(
          children: <Widget>[
            SearchBar(
              controller: TextEditingController(),
              focusNode: FocusNode(),
              hintText: 'Email',
              search: () {},
            ),
          ],
        ),
      ),
    );
  }
}
