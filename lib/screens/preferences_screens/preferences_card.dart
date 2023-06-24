import 'package:flutter/material.dart';
import 'package:tripplanner/services/pixaby_api.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class PreferencesCard extends StatefulWidget {
  const PreferencesCard({super.key});

  @override
  State<PreferencesCard> createState() => _PreferencesCardState();
}

class _PreferencesCardState extends State<PreferencesCard> {
  final String title = 'food';
  bool? isSelected = false;
  String imageUrl = '';
  String defaultImageUrl =
      'https://images.unsplash.com/photo-1527998257557-0c18b22fa4cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=736&q=80';
  final PixabyAPI pixabyAPI = PixabyAPI();
  //
  @override
  void initState() {
    super.initState();
    //
    getImage();
  }

  //
  Future<void> getImage() async {
    dynamic result = await pixabyAPI.getImage(title);
    //
    if (result != null) {
      setState(() {
        imageUrl = result;
      });
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(spacing_16),
          margin: const EdgeInsets.all(spacing_8),
          width: (spacing_8 * 20),
          height: (spacing_8 * 25),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(
                imageUrl == '' ? defaultImageUrl : imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(spacing_16),
          margin: const EdgeInsets.all(spacing_8),
          width: (spacing_8 * 20),
          height: (spacing_8 * 25),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: white_60,
                    ),
              ),
            ],
          ),
        ),
        Positioned(
          top: spacing_16,
          right: spacing_24,
          child: CircleAvatar(
            backgroundColor: searchBarColor.withOpacity(0.7),
            child: Checkbox(
              value: isSelected,
              onChanged: (value) {
                //
                setState(() {
                  isSelected = value;
                });
              },
              activeColor: green_10,
            ),
          ),
        )
      ],
    );
  }
}
