import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripplanner/models/city_model.dart';
import 'package:tripplanner/screens/home_screens/explore_screens/destination_detail_screen.dart';
import 'package:tripplanner/services/firestore_services/users_crud_services.dart';
import 'package:tripplanner/services/local_services.dart';
import 'package:tripplanner/services/pixaby_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';

class DestinationCard extends StatefulWidget {
  final CityModel destination;
  final String userId;
  final bool liked;
  final Function updateLikes;
  //
  const DestinationCard({
    super.key,
    required this.destination,
    required this.userId,
    required this.liked,
    required this.updateLikes,
  });

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard> {
  final PixabyAPI pixabyAPI = PixabyAPI();
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
    //
    getImage();
  }

  //
  Future<void> getImage() async {
    dynamic result = await pixabyAPI.getImage(widget.destination.name);
    //
    if (result != null) {
      setState(() {
        imageLink = result;
      });
    }
  }

  //
  Future<void> likeUnlikeDestination() async {
    dynamic result;

    if (like) {
      result = await usersCRUD.removeDestinationLike(widget.destination.id);
    } else {
      result = await usersCRUD.addDestinationLike(widget.destination.id);
    }
    //
    if (result == null) {
      setState(() {
        like = !like;
        //
        widget.updateLikes(like, widget.destination.id);
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
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
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
              width: (spacing_8 * 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    child: Image.network(
                      imageLink,
                      fit: BoxFit.cover,
                      width: (spacing_8 * 32),
                      height: (spacing_8 * 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(spacing_16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.destination.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        addVerticalSpace(spacing_8),
                        Text(
                          widget.destination.name == widget.destination.country
                              ? ''
                              : widget.destination.country,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
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
                            Text(widget.destination.views.toString()),
                            addHorizontalSpace(spacing_16),
                            Icon(
                              Icons.favorite,
                              color: errorColor,
                            ),
                            addHorizontalSpace(spacing_8),
                            Text(widget.destination.likes.toString()),
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
                  await localService.addDestinationView(
                    widget.userId,
                    widget.destination.id,
                  );
                  //
                  if (context.mounted) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DestinationDetail(
                          destination: widget.destination,
                          liked: like,
                          updateLikes: widget.updateLikes,
                        );
                      },
                    ));
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
                  await likeUnlikeDestination();
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
