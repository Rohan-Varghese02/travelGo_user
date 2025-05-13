import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/hive_model/journal_entry.dart';
import 'package:travelgo_user/features/logic/journal/journal_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/journal_page/widgets/journal_pick_image.dart';
import 'package:travelgo_user/features/view/screens/pages/journal_page/widgets/journal_text_field.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_user/features/view/widgets/square_elevated_btn.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class JournalEntryPage extends StatefulWidget {
  final bool isEditing;
  final JournalEntry? existingEntry;
  final int? entryKey;

  const JournalEntryPage({
    super.key,
    this.isEditing = false,
    this.existingEntry,
    this.entryKey,
  });

  @override
  State<JournalEntryPage> createState() => _JournalEntryPageState();
}

class _JournalEntryPageState extends State<JournalEntryPage> {
  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.existingEntry != null) {
      _images =
          widget.existingEntry!.imagePaths.map((path) => XFile(path)).toList();
      titleController.text = widget.existingEntry!.title; // New
      descController.text = widget.existingEntry!.description;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  final TextEditingController titleController = TextEditingController();

  final descController = TextEditingController();
  List<XFile> _images = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _images.addAll(images);
      });
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: StyleText(text: message, color: white),
        backgroundColor: redeError,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _saveEntry() {
    final title = titleController.text.trim();
    final desc = descController.text.trim();

    if (_images.isEmpty) return _showSnack('Please add at least one photo');
    if (title.isEmpty) return _showSnack('Title cannot be empty');
    if (desc.isEmpty) return _showSnack('Description cannot be empty');

    final entry = JournalEntry(
      imagePaths: _images.map((x) => x.path).toList(),
      title: titleController.text.trim(),
      description: descController.text.trim(),
      createdAt: widget.existingEntry?.createdAt ?? DateTime.now(),
    );

    final bloc = context.read<JournalBloc>();

    if (widget.isEditing && widget.entryKey != null) {
      bloc.add(EditJournalEntry(key: widget.entryKey!, updatedEntry: entry));
    } else {
      bloc.add(AddJournalEntry(entry));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: widget.isEditing ? 'Edit Journal Entry' : 'New Journal Entry',
        color: white,
        backgroundColor: themeColor,
        showBack: true,
        center: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            HeadingTextField(
              headline: 'Title',
              controller: titleController,
              hint: 'Enter title',
            ),
            SizedBox(height: 12),
            JournalPickImage(onTap: _pickImages),

            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  _images.map((image) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.file(
                          File(image.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _images.remove(image);
                            });
                          },
                        ),
                      ],
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),

            JournalTextField(
              descController: descController,
              hint: 'Write your journal entry',
              headline: 'Description',
            ),
            SizedBox(height: 20),
            SquareElevatedBtn(
              text: 'Save',
              radius: 5,
              onPressed: _saveEntry,
              color: white,
            ),
          ],
        ),
      ),
    );
  }
}
