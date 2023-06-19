import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tripplanner/models/user_model.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ConnectionTile extends StatefulWidget {
  final UserModel user;

  const ConnectionTile({
    super.key,
    required this.user,
  });

  @override
  State<ConnectionTile> createState() => _ConnectionTileState();
}

class _ConnectionTileState extends State<ConnectionTile> {
  final String defaultAvatarImageUrl =
      'https://stickercommunity.com/uploads/main/11-01-2022-11-15-50fldsc-sticker5.webp';
  //
  late final UsersCRUD usersCRUD;
  //
  @override
  void initState() {
    super.initState();
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
  }

  //
  Future<void> removeConnection() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      confirmBtnColor: errorColor,
      text: 'Remove connection',
      confirmBtnText: 'Remove',
      onConfirmBtnTap: () async {
        if (context.mounted) {
          Navigator.pop(context);
        }
        //
        dynamic result = await usersCRUD.removeConnection(widget.user);
        //
        if (result == null) {
          Fluttertoast.showToast(
            msg: "Connection removed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: green_10.withOpacity(0.5),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: "$result!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: errorColor.withOpacity(0.5),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: green_10,
        backgroundImage:
            NetworkImage(widget.user.photoURL ?? defaultAvatarImageUrl),
      ),
      title: Text(
        widget.user.username,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        widget.user.email,
        style: Theme.of(context).textTheme.labelSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        onPressed: () async {
          await removeConnection();
        },
        icon: Icon(
          Icons.delete_outline,
          color: errorColor.withOpacity(0.8),
        ),
      ),
    );
  }
}
