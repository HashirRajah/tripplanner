import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tripplanner/screens/maps/simple_map_screen.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class MapPOIDetailSliverAppBar extends StatefulWidget {
  final String imageLink;
  final bool liked;
  final int id;
  final Function updateLikes;
  //
  const MapPOIDetailSliverAppBar({
    super.key,
    required this.imageLink,
    required this.liked,
    required this.id,
    required this.updateLikes,
  });

  @override
  State<MapPOIDetailSliverAppBar> createState() =>
      _MapPOIDetailSliverAppBarState();
}

class _MapPOIDetailSliverAppBarState extends State<MapPOIDetailSliverAppBar> {
  late bool like;
  late UsersCRUD usersCRUD;
  //
  @override
  void initState() {
    super.initState();
    //
    String userId = Provider.of<User?>(context, listen: false)!.uid;
    //
    usersCRUD = UsersCRUD(uid: userId);
    //
    like = widget.liked;
  }

  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  //
  Future<void> likeUnlikePOI() async {
    dynamic result;

    if (like) {
      result = await usersCRUD.removePOILike(widget.id);
    } else {
      result = await usersCRUD.addPOILike(widget.id);
    }
    //
    if (result == null) {
      setState(() {
        like = !like;
        //
        widget.updateLikes(like, widget.id);
      });
    } else {
      Fluttertoast.showToast(
        msg: "Could not like / unlike destination",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: green_10.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    double screenWidth = getScreenWidth(context);
    //
    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      systemOverlayStyle: overlayStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(screenWidth / 2, 1),
          bottomRight: Radius.elliptical(screenWidth / 2, 1),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.9),
          foregroundColor: white_60,
          child: const BackButton(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.9),
            foregroundColor: white_60,
            child: IconButton(
              onPressed: () async {
                await likeUnlikePOI();
              },
              icon: Icon(
                like ? Icons.favorite : Icons.favorite_outline,
                color: errorColor,
              ),
            ),
          ),
        )
      ],
      expandedHeight: (spacing_8 * 25),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          widget.imageLink,
          fit: BoxFit.cover,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(spacing_32),
        child: Container(
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
      ),
    );
  }
}