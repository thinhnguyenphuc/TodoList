class Task{
  final int id;
  final String title;
  final String description;
  final DateTime time;

  Task({required this.id ,required this.title,required this.description,required this.time});

  Task.fromJson(Map<String, dynamic> json)
      : id= json["id"],
        title= json["title"],
        description= json["description"],
        time= DateTime.parse(json["time"]);

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'title': title,
      'description': description,
      'time': time.toIso8601String(),
    };
  }
}