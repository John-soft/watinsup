import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watinsup/common/enums/message_enums.dart';
import 'package:watinsup/features/chat/widgets/video_player_item.dart';

class DisplayDataType extends StatelessWidget {
  const DisplayDataType({super.key, required this.message, required this.type});

  final String message;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.video
            ? VideoPlayerItem(
                videoUrl: message,
              )
            : type == MessageEnum.gif
                ? CachedNetworkImage(
                    imageUrl: message,
                  )
                : CachedNetworkImage(
                    imageUrl: message,
                  );
  }
}
