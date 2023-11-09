import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/models/user_model.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InvitationTile extends StatefulWidget {
  final UserModel user;

  const InvitationTile({
    super.key,
    required this.user,
  });

  @override
  State<InvitationTile> createState() => _InvitationTileState();
}

class _InvitationTileState extends State<InvitationTile> {
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
  Future<void> acceptInvitation() async {
    dynamic result = await usersCRUD.addConnection(widget.user);
    //
    if (result == null) {
      Fluttertoast.showToast(
        msg: "Connection added",
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
  }

  Future<void> rejectInvitation() async {
    dynamic result = await usersCRUD.removeInvitation(widget.user);
    //
    if (result == null) {
      Fluttertoast.showToast(
        msg: "Invitation rejected",
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
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
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
      trailing: SizedBox(
        width: getXPercentScreenWidth(25, screenWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () async {
                await acceptInvitation();
              },
              icon: Icon(
                Icons.done,
                color: green_30.withOpacity(0.8),
              ),
            ),
            IconButton(
              onPressed: () async {
                await rejectInvitation();
              },
              icon: Icon(
                Icons.remove,
                color: errorColor.withOpacity(0.8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
