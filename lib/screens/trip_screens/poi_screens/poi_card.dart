import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripplanner/business_logic/cubits/trip_id_cubit/trip_id_cubit.dart';
import 'package:tripplanner/models/poi_model.dart';
import 'package:tripplanner/screens/trip_screens/poi_screens/poi_details_screen.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class POICard extends StatefulWidget {
  final POIModel poi;
  final type;
  final String userId;
  final bool liked;
  final Function updateLikes;
  //
  const POICard({
    super.key,
    required this.poi,
    required this.type,
    required this.userId,
    required this.liked,
    required this.updateLikes,
  });

  @override
  State<POICard> createState() => _POICardState();
}

class _POICardState extends State<POICard> {
  final LocalService localService = LocalService();
  late bool like;
  late UsersCRUD usersCRUD;
  String imageLink =
      'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1121&q=80';
  //
  @override
  void initState() {
    super.initState();
    //
    like = widget.liked;
    usersCRUD = UsersCRUD(uid: widget.userId);
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
      result = await usersCRUD.removePOILike(widget.poi.id);
    } else {
      result = await usersCRUD.addPOILike(widget.poi.id);
    }
    //
    if (result == null) {
      setState(() {
        like = !like;
        //
        widget.updateLikes(like, widget.poi.id);
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

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: spacing_8),
      child: Stack(
        children: <Widget>[
          Card(
            elevation: 3.0,
            color: tripCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: SizedBox(
              width: (spacing_8 * 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    child: Hero(
                      tag: '${widget.type}-poi-${widget.poi.id}',
                      child: Image.network(
                        widget.poi.image,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(imageLink);
                        },
                        fit: BoxFit.cover,
                        width: (spacing_8 * 35),
                        height: (spacing_8 * 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(spacing_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.poi.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(spacing_8),
                        Text(
                          widget.poi.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(spacing_16),
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              color: gold,
                            ),
                            addHorizontalSpace(spacing_8),
                            Text(widget.poi.views.toString()),
                            addHorizontalSpace(spacing_16),
                            Icon(
                              Icons.favorite,
                              color: errorColor,
                            ),
                            addHorizontalSpace(spacing_8),
                            Text(widget.poi.likes.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: spacing_16,
            right: spacing_16,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () async {
                  //
                  await localService.addPOIView(widget.userId, widget.poi.id);
                  //
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (newContext) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: BlocProvider.of<TripIdCubit>(context),
                            )
                          ],
                          child: POIDetailsScreen(
                            poi: widget.poi,
                            liked: like,
                            updateLikes: widget.updateLikes,
                          ),
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward_outlined),
              ),
            ),
          ),
          Positioned(
            top: spacing_16,
            right: spacing_16,
            child: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.4),
              foregroundColor: white_60,
              child: IconButton(
                onPressed: () async {
                  await likeUnlikePOI();
                },
                icon: Icon(
                  like ? Icons.favorite : Icons.favorite_border,
                  color: errorColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
