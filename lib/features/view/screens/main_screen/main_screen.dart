import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/logic/nav/nav_bloc.dart';
import 'package:travelgo_user/features/view/screens/main_screen/widgets/bottom_nav_bar.dart';
import 'package:travelgo_user/features/view/screens/pages/blog_page/blog_page.dart';
import 'package:travelgo_user/features/view/screens/pages/chat_page/chat_page.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/home_page.dart';
import 'package:travelgo_user/features/view/screens/pages/journal_page/journal_page.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/profile_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.userdata});
  final UserDataModel userdata;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomePage(userdata: userdata,),
      BlogPage(),
      JournalPage(),
      ChatPage(),
      ProfilePage(),
    ];
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state.index, children: screens),
          bottomNavigationBar: BottomNavBar(),
        );
      },
    );
  }
}
