import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class DeleteExpenseButton extends StatelessWidget {
  final int index;
  final Function delete;
  //
  const DeleteExpenseButton({
    super.key,
    required this.index,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          text: 'Delete expense permanently',
          confirmBtnColor: errorColor,
          customAsset: 'assets/gifs/bin.gif',
          onConfirmBtnTap: () async {
            //
            if (context.mounted) {
              Navigator.pop(context);
            }
            //
            await delete(index);
          },
        );
      },
      icon: Icon(
        Icons.delete,
        color: airportTransfersCardColor,
      ),
    );
  }
}
