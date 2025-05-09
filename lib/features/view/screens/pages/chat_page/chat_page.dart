import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/logic/user/user_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/chat_page/chat_detailed_page.dart';
import 'package:travelgo_user/features/view/screens/pages/chat_page/widgets/chat_tile.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class ChatPage extends StatelessWidget {
  final UserDataModel userData;
  final String userid;
  const ChatPage({super.key, required this.userid, required this.userData});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) => current is NavigateToChat,
      listener: (context, state) {
        if (state is NavigateToChat) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => ChatDetailedPage(
                      userData: state.userData,
                      chatData: state.chat,
                    ),
              ),
            );
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Chat',
          color: white,
          backgroundColor: themeColor,
          center: true,
          showBack: false,
        ),
        body: StreamBuilder(
          stream: StreamServices().getChat(userid),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return Center(child: StyleText(text: 'No active chats'));
            } else {
              final chats = snapshot.data;
              return ListView.builder(
                itemCount: chats!.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        context.read<UserBloc>().add(
                          Chat(userData: userData, chat: chat),
                        );
                      },
                      child: ChatTile(chatData: chat),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
