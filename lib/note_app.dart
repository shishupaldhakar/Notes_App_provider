import 'package:flutter/material.dart';
import 'package:noteapp_provider/ui_helper.dart';

import 'package:provider/provider.dart';

import 'db_helper.dart';

import 'notes_model.dart';

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController tTitleController = TextEditingController();
  TextEditingController dDescController = TextEditingController();
  addData(String title, String desc) {
    context
        .read<NotesProvider>()
        .addNotes(NotesModel(title: title, desc: desc));
  }

  updateData(String title, String desc, int id) {
    context
        .read<NotesProvider>()
        .updateNotes(NotesModel(title: title, desc: desc, id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotesApp'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<NotesProvider>(
        builder: (_, provider, __) {
          return ListView.builder(
            itemCount: provider.getAllNotes().length,
            itemBuilder: (context, index) {
              var currentData = provider.getAllNotes()[index];
              return InkWell(
                  onTap: () {
                    tTitleController.text = currentData.title;
                    dDescController.text = currentData.desc;
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              height: 300,
                              width: double.infinity,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    UiHelper.customTextField(tTitleController,
                                        'title', Icons.title, 1),
                                    UiHelper.customTextField(
                                        dDescController,
                                        'Description',
                                        Icons.description_outlined,
                                        1),
                                    ElevatedButton(
                                        onPressed: () {
                                          updateData(
                                              tTitleController.text.toString(),
                                              dDescController.text.toString(),
                                              currentData.id as int);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update Data'))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: ListTile(
                    leading: Text('${currentData.id}'),
                    title: Text(currentData.title),
                    subtitle: Text(currentData.desc),
                    trailing: IconButton(
                      onPressed: () {
                        provider.deleteNotes(currentData.id as int);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }

  _showBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 300,
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiHelper.customTextField(
                        titleController, 'title', Icons.title, 1),
                    UiHelper.customTextField(descController, 'Description',
                        Icons.description_outlined, 1),
                    ElevatedButton(
                        onPressed: () {
                          addData(titleController.text.toString(),
                              descController.text.toString());
                          Navigator.pop(context);
                        },
                        child: Text('Save'))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
