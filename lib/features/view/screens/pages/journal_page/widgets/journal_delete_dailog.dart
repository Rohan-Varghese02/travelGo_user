import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/logic/journal/journal_bloc.dart';
import 'package:travelgo_user/features/view/widgets/square_elevated_btn.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

void journalDeleteDailog(BuildContext context, String name, int key) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: StyleText(text: 'Delete Jorunal'),
        content: StyleText(
          text: 'Do you really want to delete this Journal: $name ',
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SquareElevatedBtn(
                text: 'Cancel',
                radius: 10,
                color: black,
                backgroundColor: white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SquareElevatedBtn(
                text: 'Delete',
                radius: 10,
                color: white,
                onPressed: () async {
                  context.read<JournalBloc>().add(DeleteJournalEntry(key));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
