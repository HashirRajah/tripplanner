import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';

class SearchAutoComplete extends StatelessWidget {
  //
  final List<String> searchValues;
  final String hintText;
  //
  const SearchAutoComplete({
    super.key,
    required this.searchValues,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          return searchValues.where((element) => element
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase()));
        }
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: options.length,
              padding: const EdgeInsets.all(spacing_8),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(options.elementAt(index)),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              SearchBar(
        controller: textEditingController,
        focusNode: focusNode,
        hintText: hintText,
        search: () {},
      ),
    );
  }
}
