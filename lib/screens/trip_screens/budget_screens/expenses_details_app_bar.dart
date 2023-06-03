import 'package:flutter/material.dart';
import 'package:tripplanner/screens/trip_screens/budget_screens/budget_back_button.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/search_textfield.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class ExpensesSliverAppBar extends StatelessWidget {
  //
  final String svgFilePath = 'assets/svgs/expenses.svg';
  final String title = 'Expenses';
  final TextEditingController controller;
  final String expenseTitle;
  final Function action;
  final Function search;
  final FocusNode focusNode;
  //
  const ExpensesSliverAppBar({
    super.key,
    required this.controller,
    required this.expenseTitle,
    required this.action,
    required this.search,
    required this.focusNode,
  });
  //

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0.0,
      systemOverlayStyle: overlayStyle,
      leading: BudgetBackButton(
        action: action,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(screenWidth / 2, 1),
          bottomRight: Radius.elliptical(screenWidth / 2, 1),
        ),
      ),
      title: Text(
        expenseTitle,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold, color: white_60),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(spacing_96),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: spacing_32,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: spacing_24,
                top: spacing_24,
                right: spacing_24,
              ),
              child: SearchBar(
                controller: controller,
                focusNode: focusNode,
                hintText: 'Expenses',
                search: search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
