import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/logic/user/user_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/journal_page/widgets/journal_app_bar.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        log(state.runtimeType.toString());
      },
      child: Scaffold(
        appBar: JournalAppBar(title: 'Journal'),
        body: Column(children: [
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeColor,
          onPressed: () {
            context.read<UserBloc>().add(JournalAddEvent());
          },
          child: Icon(FontAwesomeIcons.plus, color: Colors.white),
        ),
      ),
    );
  }
}
