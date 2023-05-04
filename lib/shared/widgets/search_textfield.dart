import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class SearchBar extends StatelessWidget {
  //
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final Function search;
  //
  const SearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: (value) => search(context, value),
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
              search(context, controller.text);
            }
          },
          icon: const Icon(Icons.clear_outlined),
        ),
      ),
    );
  }
}
