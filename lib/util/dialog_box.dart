import 'package:flutter/material.dart';
import 'package:my_todo_list/util/my_botton.dart';

class DialogBox extends StatelessWidget {
  final controllerBox;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({super.key, required this.controllerBox, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // User input text
            TextField(
                controller: controllerBox,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a new task!',
                )),

            // Button to save & cencel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save button
                MyBotton(text: 'Save', onPressed: onSave),
                const SizedBox(width: 5),

                // Cancel button
                MyBotton(text: 'Cancel', onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
