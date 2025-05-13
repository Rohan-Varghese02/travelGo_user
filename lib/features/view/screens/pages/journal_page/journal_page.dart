import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/logic/journal/journal_bloc.dart';
import 'package:travelgo_user/features/logic/user/user_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/journal_page/journal_detailed_page.dart';
import 'package:travelgo_user/features/view/screens/pages/journal_page/journal_entry_page.dart';
import 'package:travelgo_user/features/view/screens/pages/journal_page/widgets/journal_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

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
        body: BlocBuilder<JournalBloc, JournalState>(
          builder: (context, state) {
            if (state is JournalLoaded) {
              return ListView.builder(
                itemCount: state.entries.length,
                itemBuilder: (context, index) {
                  final entryWithKey = state.entries[index];
                  final key = entryWithKey.key;
                  final entry = entryWithKey.value;

                  return Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: grey20),
                    ),
                    child: ListTile(
                      leading: Image.file(
                        File(entry.imagePaths.first),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(entry.title),
                      subtitle: StyleText(text: 'Journal Entry: ${index + 1}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: themeColor),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => JournalEntryPage(
                                        isEditing: true,
                                        existingEntry: entry,
                                        entryKey: key,
                                      ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: redeError),
                            onPressed: () {
                              context.read<JournalBloc>().add(
                                DeleteJournalEntry(key),
                              );
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => JournalDetailPage(entry: entry),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeColor,
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => JournalEntryPage()));
          },
          child: Icon(FontAwesomeIcons.plus, color: white),
        ),
      ),
    );
  }
}
