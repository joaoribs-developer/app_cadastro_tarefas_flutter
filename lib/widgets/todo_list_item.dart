import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/Todos.dart';

class TodoListItem extends StatelessWidget {
   TodoListItem({Key? key, required this.todo, required this.onDelete}) : super(key: key);
  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key:  ValueKey(0),
      endActionPane: ActionPane(
        extentRatio: 0.30,
        children:[
          SlidableAction(
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: onDelete(todo),

          )
        ],
        motion: ScrollMotion(),
      ),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[400],
        ),
        padding: const EdgeInsets.all(16),
        margin: const  EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd/MM/yyyy - HH:mm').format(todo.data),
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              todo.nome,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
