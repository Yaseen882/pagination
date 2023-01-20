import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAvatarWidget extends StatelessWidget {
  final String networkImageUrl;
  const CustomAvatarWidget({Key? key, required this.networkImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: networkImageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
              ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => FaIcon(FontAwesomeIcons.camera),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
