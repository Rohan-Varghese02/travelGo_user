import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/chat_services.dart';
import 'package:travelgo_user/data/models/chat_data.dart';
import 'package:travelgo_user/data/models/message_data.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/chat_page/widgets/chat_custom_appBar.dart';
import 'package:travelgo_user/features/view/screens/pages/chat_page/widgets/message_tile.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class ChatDetailedPage extends StatefulWidget {
  final UserDataModel userData;
  final ChatData chatData;
  ChatDetailedPage({super.key, required this.userData, required this.chatData});

  @override
  State<ChatDetailedPage> createState() => _ChatDetailedPageState();
}

class _ChatDetailedPageState extends State<ChatDetailedPage> {
  @override
  void initState() {
    super.initState();
    ChatServices().updateSeen(
      Timestamp.now(),
      widget.chatData.organizerUid,
      widget.userData.uid,
    );
  }

  TextEditingController messageController = TextEditingController();

  Map<String, List<MessageData>> groupMessagesByDate(
    List<MessageData> messages,
  ) {
    Map<String, List<MessageData>> grouped = {};

    for (var message in messages) {
      final date = message.timestamp.toDate();
      final now = DateTime.now();

      String label;
      if (DateUtils.isSameDay(date, now)) {
        label = 'Today';
      } else if (DateUtils.isSameDay(date, now.subtract(Duration(days: 1)))) {
        label = 'Yesterday';
      } else {
        label = DateFormat('MMMM d, yyyy').format(date);
      }

      grouped.putIfAbsent(label, () => []).add(message);
    }

    return grouped;
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await ChatServices().sendMessage(
        widget.chatData.organizerUid,
        messageController.text,
        widget.userData.uid,
        widget.userData.email,
      );
      await ChatServices().updateMessageandTime(
        messageController.text,
        Timestamp.now(),
        widget.userData.uid,
        widget.chatData.organizerUid,
      );
      await ChatServices().updateMessageandTimeOrganizer(
        messageController.text,
        Timestamp.now(),
        widget.userData.uid,
        widget.chatData.organizerUid,
      );
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    String senderID = widget.userData.uid;
    String recieverID = widget.chatData.organizerUid;
    return Scaffold(
      appBar: ChatCustomAppBar(
        title: widget.chatData.organizerName,
        color: white,
        picUrl: widget.chatData.organizerImage,
        backgroundColor: themeColor,
        showBack: true,
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream: ChatServices().getMessage(senderID, recieverID),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: StyleText(text: 'Loading'));
                }
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: StyleText(
                      text: 'Start the conversation with Organizer',
                    ),
                  );
                }
                final messages = snapshot.data!;
                final groupedMessages = groupMessagesByDate(messages);
                final List<String> dateKeys = groupedMessages.keys.toList();

                return ListView.builder(
                  itemCount: groupedMessages.values.fold<int>(
                    0,
                    (prev, list) => prev + list.length + 1,
                  ),
                  itemBuilder: (context, index) {
                    int counter = 0;

                    for (var date in dateKeys) {
                      final msgs = groupedMessages[date]!;

                      if (index == counter) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(child: StyleText(text: date)),
                        );
                      }

                      counter++; // for header

                      for (var msg in msgs) {
                        if (index == counter) {
                          return MessageTile(
                            message: msg,
                            currentUser: widget.userData.uid,
                          );
                        }
                        counter++;
                      }
                    }

                    return SizedBox.shrink(); // fallback
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Send Message',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: themeColor,
                  ),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.arrow_upward, color: white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
