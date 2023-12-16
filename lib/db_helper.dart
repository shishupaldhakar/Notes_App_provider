import 'package:flutter/foundation.dart';

import 'note_provider.dart';
import 'notes_model.dart';

class NotesProvider extends ChangeNotifier {
  DbHelper dbHelper = DbHelper.instance;
  List<NotesModel> arrayNotes = [];
  addNotes(NotesModel notesModel) async {
    var check = await dbHelper.insertData(notesModel);
    if (check) {
      arrayNotes = await dbHelper.getData();
      notifyListeners();
    }
  }

  fetchInitialData() async {
    arrayNotes = await dbHelper.getData();
    notifyListeners();
  }

  List<NotesModel> getAllNotes() {
    fetchInitialData();
    return arrayNotes;
  }

  updateNotes(NotesModel notesModel) async {
    var check = await dbHelper.updateData(notesModel);
    if (check) {
      arrayNotes = await dbHelper.getData();
      notifyListeners();
    }
  }

  deleteNotes(int id) async {
    var check = await dbHelper.deleteNotes(id);
    if (check) {
      arrayNotes = await dbHelper.getData();
      notifyListeners();
    }
  }
}
