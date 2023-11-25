import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;


  // This is the constructor of this class
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      this.onChanged,
      this.deleteFunction
      
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction, 
              icon: Icons.delete, 
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(10),
            ),  
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Checkbox(value: taskCompleted, onChanged: onChanged),
              Text(
                taskName,
                style: TextStyle(
                    decoration:
                        taskCompleted ? TextDecoration.lineThrough : null),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
