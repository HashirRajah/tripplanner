import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class SearchBar extends StatelessWidget {
  //
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  //
  const SearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: () {
        focusNode.unfocus();
      },
      style: TextStyle(fontWeight: FontWeight.w600, color: green_10),
      decoration: searchBarInputDecoration.copyWith(
        hintText: 'Search $hintText',
        suffixIcon: IconButton(
          onPressed: () {
            if (controller.text.isEmpty) {
              focusNode.unfocus();
            } else {
              controller.clear();
            }
          },
          icon: const Icon(Icons.clear_outlined),
        ),
      ),
    );
  }
}
