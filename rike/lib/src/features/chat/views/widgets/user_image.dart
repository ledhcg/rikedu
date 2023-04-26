import 'package:flutter/material.dart';
import 'package:rike/src/constants/colors.dart';
import 'package:rike/src/features/chat/views/widgets/online_indicator.dart';

class UserImage extends StatelessWidget {
  final String imageUrl;
  final bool online;

  const UserImage({Key? key, required this.imageUrl, this.online = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(126.0),
            child: imageUrl != ''
                ? Image.network(
                    imageUrl,
                    width: 126,
                    height: 126,
                    fit: BoxFit.fill,
                  )
                : const Icon(
                    Icons.group_rounded,
                    size: 35,
                    color: rikePrimaryColor,
                  ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: online ? const OnlineIndicator() : Container(),
          )
        ],
      ),
    );
  }
}
