import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripplanner/models/useful_link_model.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class UsefulLinksCard extends StatefulWidget {
  //
  final String title;
  final List<UsefulLinkModel> links;
  final String svgFilePath;
  //
  const UsefulLinksCard({
    super.key,
    required this.title,
    required this.links,
    required this.svgFilePath,
  });

  @override
  State<UsefulLinksCard> createState() => _UsefulLinksCardState();
}

class _UsefulLinksCardState extends State<UsefulLinksCard> {
  //
  List<Widget> buildList() {
    List<Widget> linksList = [];
    //
    for (UsefulLinkModel link in widget.links) {
      linksList.add(Card(
        color: docTileColor,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          title: Text(
            link.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: green_10,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              Uri url = Uri.parse(link.link);
              //
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            icon: Icon(
              Icons.arrow_forward_outlined,
              size: Theme.of(context).textTheme.headlineSmall?.fontSize,
              color: green_10,
            ),
          ),
        ),
      ));
    }
    //
    return linksList;
  }

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      margin: const EdgeInsets.only(top: spacing_56),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(spacing_16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: tripCardColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: green_10,
                        ),
                  ),
                  addVerticalSpace(spacing_8),
                  Text(
                    'Useful links to find ${widget.title}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: green_10, fontWeight: FontWeight.bold),
                  ),
                  addVerticalSpace(spacing_16),
                  Column(
                    children: buildList(),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: -spacing_48,
            right: spacing_8,
            child: SvgPicture.asset(
              widget.svgFilePath,
              height: (spacing_8 * 12),
            ),
          ),
        ],
      ),
    );
  }
}
