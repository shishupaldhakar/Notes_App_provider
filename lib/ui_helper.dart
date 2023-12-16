import 'package:flutter/material.dart';

class UiHelper {
  static customTextField(TextEditingController controller, String text,
      IconData iconData, int maxLine) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
          maxLines: maxLine,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            fillColor: Colors.teal.withOpacity(0.5),
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(iconData),
            filled: true,
            hintText: text,
          )),
    );
  }

  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
          );
        });
  }
}
