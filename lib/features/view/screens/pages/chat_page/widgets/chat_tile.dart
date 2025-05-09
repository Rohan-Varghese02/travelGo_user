import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/chat_data.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class ChatTile extends StatelessWidget {
  final ChatData chatData;
  const ChatTile({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    final timeText = DateFormat(
      'HH:mm',
    ).format(chatData.lastMessageTime.toDate());

    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1, color: grey20)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chatData.organizerImage),
        ),
        title: StyleText(text: chatData.organizerName),
        subtitle:
            chatData.lastMessageBool
                ? StyleText(text: chatData.lastMessage)
                : StyleText(
                  text: chatData.lastMessage,
                  fontWeight: FontWeight.bold,
                ),
        trailing: StyleText(text: timeText),
      ),
    );
  }
}
