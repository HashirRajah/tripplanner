import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripplanner/business_logic/blocs/share_trip_bloc/share_trip_bloc.dart';
import 'package:tripplanner/models/user_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ShareWithTile extends StatefulWidget {
  final UserModel user;
  //
  const ShareWithTile({
    super.key,
    required this.user,
  });

  @override
  State<ShareWithTile> createState() => _ShareWithTileState();
}

class _ShareWithTileState extends State<ShareWithTile> {
  final String defaultAvatarImageUrl =
      'https://stickercommunity.com/uploads/main/11-01-2022-11-15-50fldsc-sticker5.webp';
  //

  bool? isSelected = false;
  //
  @override
  void initState() {
    super.initState();
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
      trailing: Checkbox(
        value: isSelected,
        onChanged: (value) {
          //
          if (value == true) {
            BlocProvider.of<ShareTripBloc>(context)
                .addShareWith(widget.user.uid);
          } else {
            BlocProvider.of<ShareTripBloc>(context)
                .removeShareWith(widget.user.uid);
          }

          //
          setState(() {
            isSelected = value;
          });
        },
        activeColor: green_10,
      ),
    );
  }
}
