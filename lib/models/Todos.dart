class Todo{
  Todo({required this.data,required this.nome});

  Todo.fromJson(Map<String, dynamic> json):
        nome = json['nome'],
        data = DateTime.parse(json['data']);

  String nome;
  DateTime data;

  Map<String, dynamic>toJson(){
    return{
      "nome": nome,
      "data": data.toIso8601String()
    };
  }
}