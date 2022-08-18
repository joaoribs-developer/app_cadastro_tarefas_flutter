import 'package:flutter/material.dart';
import 'package:lista_tarefas_curso/widgets/todo_list_item.dart';

import '../models/Todos.dart';

class TodoList extends StatefulWidget {
  TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? todoRevertDelete;
  int? todoRevertPosition;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: todoController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Adiconar nova tarefa",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(14),
                                // primary: Colors.blue,
                                primary: const Color(0xff00d7f3)),
                            onPressed: () {
                              setState(() {
                                String text = todoController.text;
                                if (text == "") {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text(
                                                "Tarefa não adicionada"),
                                            content: const Text(
                                                "Impossivel adiconar uma tarefa em branco, preencha os campos"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("OK"))
                                            ],
                                          ));
                                } else {
                                  Todo newTodo =
                                      Todo(nome: text, data: DateTime.now());
                                  todos.add(newTodo);
                                }
                              });
                              todoController.clear();
                            },
                            child: const Icon(
                              Icons.add,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            for (Todo todo in todos)
                              TodoListItem(todo: todo, onDelete: onDelete)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                  "Você tem ${todos.length} tarefas pendentes")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(14),
                                  // primary: Colors.blue,
                                  primary: const Color(0xff00d7f3)),
                              onPressed: () {
                                apagarTudo();
                              },
                              child: const Text("Limpar tudo"))
                        ],
                      )
                    ],
                  )))),
    );
  }

  void apagarTudo() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: Text("Apagar tudo?"),
              content: Text("Realmente deseja apagar todas as tarefas??"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("CANCELAR",
                        style: TextStyle(color: Color(0xff00d7f3)))),
                TextButton(
                    onPressed: () {
                      setState(() {
                        todos.clear();
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                        "Todas as tarefas foram excluidas com sucesso",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      duration: Duration(seconds: 5)));
                    },
                    child: Text(
                      "CONFIRMAR",
                      style: TextStyle(color: Color(0xff00d7f3)),
                    ))
              ],
            ));
  }

  void onDelete(Todo todo) {
    todoRevertDelete = todo;
    todoRevertPosition = todos.indexOf(todo);
    if (mounted) {
      setState(() {
        todos.remove(todo);
      });
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "A tarefa ${todo.nome} foi excluida com sucesso",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: "Desfazer",
        textColor: Color(0xff00d7f3),
        onPressed: () {
          setState(() {
            todos.insert(
              todoRevertPosition!,
              todoRevertDelete!,
            );
          });
        },
      ),
    ));
  }
}
