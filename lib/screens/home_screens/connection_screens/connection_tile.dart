import 'package:flutter/material.dart';
import 'package:tripplanner/models/user_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class ConnectionTile extends StatelessWidget {
  final UserModel user;
  final String defaultAvatarImageUrl =
      'https://stickercommunity.com/uploads/main/11-01-2022-11-15-50fldsc-sticker5.webp';
  //
  const ConnectionTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: green_10,
        backgroundImage: NetworkImage(user.photoURL ?? defaultAvatarImageUrl),
      ),
      title: Text(
        user.username,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        user.email,
        style: Theme.of(context).textTheme.labelSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.delete_outline,
          color: errorColor.withOpacity(0.8),
        ),
      ),
    );
  }
}
