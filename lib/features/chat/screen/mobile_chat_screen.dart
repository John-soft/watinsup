// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:watinsup/colors.dart';
import 'package:watinsup/common/widgets/loader.dart';
import 'package:watinsup/features/auth/controller/auth_controller.dart';
import 'package:watinsup/features/chat/widgets/bottom_chat_field.dart';
import 'package:watinsup/models/user_model.dart';

import '../widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat';

  final String name;
  final String uid;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref.read(authControllerProvider).getUserDataById(uid),
            builder: (context, snapshot) {
              final isOnline = snapshot.data!.isOnline;
              Color containerColor = isOnline ? Colors.green : Colors.grey;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: containerColor,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        isOnline ? 'online' : 'offline',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                ],
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              receiverUserId: uid,
            ),
          ),
          BottomChatField(
            receiverUserId: uid,
          ),
        ],
      ),
    );
  }
}
