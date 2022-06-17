import 'dart:async';

import 'package:bloknot/constants/colors.dart';
import 'package:bloknot/db/database.dart';
import 'package:bloknot/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  final notesController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    ref.read(dbProvider).allNotes.then((value) {
      if (value.isNotEmpty) {
        notesController.value = notesController.value.copyWith(
          text: value[0].note,
          selection: TextSelection.fromPosition(
            TextPosition(offset: value[0].note.length),
          ),
        );
      }
    });
  }

  Future<bool> _saveNotes() async {
    await ref
        .read(dbProvider)
        .updateNote(Note(id: 0, note: notesController.text))
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Сохранено'))));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _saveNotes,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryText.withAlpha(20),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: notesController,
                      decoration: const InputDecoration(
                        hintText: "Ваши заметки...",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autofocus: true,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
