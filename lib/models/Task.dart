class Task{
  final int id;
  final String title;
  final String description;
  final DateTime time;

  Task({required this.id ,required this.title,required this.description,required this.time});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        time: json["time"]
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'title': title,
      'description': description,
      'time': time,
    };
  }
}