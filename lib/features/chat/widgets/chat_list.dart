import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watinsup/common/enums/message_enums.dart';
import 'package:watinsup/common/providers/message_reply_providers.dart';
import 'package:watinsup/common/widgets/loader.dart';
import 'package:watinsup/features/chat/controller/chat_controller.dart';
import 'package:watinsup/features/chat/widgets/message_sender_card.dart';
import 'package:watinsup/features/chat/widgets/my_message_card.dart';
import 'package:watinsup/models/message.dart';
import 'package:watinsup/utils/time_format.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({Key? key, required this.receiverUserId}) : super(key: key);

  final String receiverUserId;

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final messageController = ScrollController();

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref.read(messageReplyProvider.notifier).update(
          (state) => MessageReply(
            message,
            isMe,
            messageEnum,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream:
            ref.watch(chatControllerProvider).chatStream(widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];

              if (!messageData.isSeen &&
                  messageData.receiverId ==
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                      context,
                      widget.receiverUserId,
                      messageData.messageId,
                    );
              }
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: formattedTimeStamp(messageData.timeSent),
                  type: messageData.type,
                  onLeftSwipe: () => onMessageSwipe(
                    messageData.text,
                    true,
                    messageData.type,
                  ),
                  repliedMessageType: messageData.repliedMessageType,
                  repliedText: messageData.repliedMessage,
                  username: messageData.repliedTo,
                  isSeen: messageData.isSeen,
                );
              }
              return SenderMessageCard(
                message: messageData.text,
                date: formattedTimeStamp(messageData.timeSent),
                type: messageData.type,
                onRightSwipe: () => onMessageSwipe(
                  messageData.text,
                  false,
                  messageData.type,
                ),
                repliedMessageType: messageData.repliedMessageType,
                repliedText: messageData.repliedMessage,
                username: messageData.repliedTo,
              );
            },
          );
        });
  }
}
