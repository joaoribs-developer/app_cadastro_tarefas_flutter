import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Todos.dart';
class TodoRepository{
late SharedPreferences sharedPreferences;

Future<List<Todo>> getTodoList() async{
    sharedPreferences = await SharedPreferences.getInstance();
    final String getJson = sharedPreferences.getString("todo_list") ?? "[]";
    final List jsonDecode = json.decode(getJson) as List;
    return jsonDecode.map((e) => Todo.fromJson(e)).toList();
  }

void saveTaskList(List<Todo> todos){
  final jsonEncode = json.encode(todos);
  sharedPreferences.setString("todo_list", jsonEncode);
  print(jsonEncode);
}

}