import 'package:flutter/material.dart';
import 'package:tripplanner/models/embassy_info_model.dart';
import 'package:tripplanner/screens/webview_screens/webview.dart';
import 'package:tripplanner/services/embassy_info_service.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:tripplanner/shared/widgets/elevated_buttons_wrapper.dart';
import 'package:tripplanner/shared/widgets/error_state.dart';
import 'package:tripplanner/utils/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class EmbassySection extends StatefulWidget {
  final String country;
  //
  const EmbassySection({
    super.key,
    required this.country,
  });

  @override
  State<EmbassySection> createState() => _EmbassySectionState();
}

class _EmbassySectionState extends State<EmbassySection> {
  final String svgFilePath = 'assets/svgs/investigate.svg';
  bool dataFetched = false;
  bool infoError = false;
  EmbassyInfoModel? embassyInfo;
  final EmbassyInfoService eiService = EmbassyInfoService();
  //
  @override
  void initState() {
    super.initState();
    //
    fetchEmbassyInfo();
  }

  //
  //
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //
  Future<void> fetchEmbassyInfo() async {
    //
    if (dataFetched) {
      setState(() {
        dataFetched = false;
      });
    }
    //
    dynamic result =
        await eiService.getEmbassyInfo('mauritius', widget.country);
    //
    if (result == null) {
      infoError = true;
    } else {
      embassyInfo = result;
    }
    //
    dataFetched = true;
    setState(() {});
  }

  //
  Widget buildPhoneSection() {
    List<Widget> phoneNumbers = [];
    for (String number in embassyInfo!.phoneNumbers) {
      phoneNumbers.add(Container(
        margin: const EdgeInsets.only(bottom: spacing_8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(number),
            CircleAvatar(
              backgroundColor: green_10,
              child: IconButton(
                onPressed: () async {
                  final Uri numberUrl = Uri(
                    scheme: 'tel',
                    path: number,
                  );
                  //
                  if (await canLaunchUrl(numberUrl)) {
                    //
                    launchUrl(numberUrl);
                  }
                },
                icon: const Icon(
                  Icons.phone,
                  color: Colors.greenAccent,
                ),
              ),
            )
          ],
        ),
      ));
    }
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: phoneNumbers,
    );
  }

  //
  //
  Widget buildEmailSection() {
    List<Widget> emails = [];
    for (String email in embassyInfo!.emails) {
      emails.add(Container(
        margin: const EdgeInsets.only(bottom: spacing_8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              email,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            CircleAvatar(
              backgroundColor: green_10,
              child: IconButton(
                onPressed: () async {
                  final Uri emailUrl = Uri(
                    scheme: 'mailto',
                    path: email,
                  );
                  //
                  if (await canLaunchUrl(emailUrl)) {
                    //
                    launchUrl(emailUrl);
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.amberAccent,
                ),
              ),
            )
          ],
        ),
      ));
    }
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: emails,
    );
  }

  //
  Widget buildFaxSection() {
    List<Widget> faxes = [];
    for (String fax in embassyInfo!.faxes) {
      faxes.add(
        Container(
          margin: const EdgeInsets.only(bottom: spacing_8),
          child: Text(fax),
        ),
      );
    }
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: faxes,
    );
  }

  //
  Widget buildBody() {
    if (!dataFetched) {
      return const Center(child: CircularProgressIndicator());
    } else if (infoError) {
      return ErrorStateWidget(
        action: fetchEmbassyInfo,
      );
    } else {
      if (embassyInfo!.status != 'ok') {
        return Column(
          children: [
            const Text('Visit link for more info!'),
            addVerticalSpace(spacing_16),
            ElevatedButtonWrapper(
              childWidget: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        final String url = embassyInfo!.url;
                        //
                        return WebViewScreen(url: url);
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.link),
                label: const Text('More Info'),
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.location_on_outlined),
                    addHorizontalSpace(spacing_16),
                    Text(
                      'Address',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                addVerticalSpace(spacing_8),
                Text(embassyInfo!.address),
              ],
            ),
            addVerticalSpace(spacing_16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.phone),
                    addHorizontalSpace(spacing_16),
                    Text(
                      'Phone',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                addVerticalSpace(spacing_8),
                buildPhoneSection(),
              ],
            ),
            addVerticalSpace(spacing_16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.fax),
                    addHorizontalSpace(spacing_16),
                    Text(
                      'Fax',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                addVerticalSpace(spacing_8),
                buildFaxSection(),
              ],
            ),
            addVerticalSpace(spacing_16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.email),
                    addHorizontalSpace(spacing_16),
                    Text(
                      'Email',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                addVerticalSpace(spacing_8),
                buildEmailSection(),
              ],
            ),
            addVerticalSpace(spacing_16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        const Icon(Icons.link),
                        addHorizontalSpace(spacing_16),
                        Text(
                          'Website URL',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: green_10,
                      child: IconButton(
                        onPressed: () async {
                          Uri url = Uri.parse(embassyInfo!.websiteUrl);
                          url = url.resolve(embassyInfo!.websiteUrl);
                          //
                          if (await canLaunchUrl(url)) {
                            launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(spacing_8),
                Text(embassyInfo!.websiteUrl),
              ],
            ),
            addVerticalSpace(spacing_16),
            ElevatedButtonWrapper(
              childWidget: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        final String url = embassyInfo!.url;
                        //
                        return WebViewScreen(url: url);
                      },
                    ),
                  );
                },
                child: const Text('More Info'),
              ),
            ),
          ],
        );
      }
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(spacing_16),
      decoration: BoxDecoration(
        color: tripCardColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            embassyInfo != null
                ? (embassyInfo!.title != '')
                    ? embassyInfo!.title
                    : 'Embassy'
                : 'Embassy',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          addVerticalSpace(spacing_32),
          buildBody(),
        ],
      ),
    );
  }
}
