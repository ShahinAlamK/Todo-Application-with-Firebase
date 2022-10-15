class TodoModel{
  String?id;
  String? title;
  String? description;
  bool?isComplete;
  int? dateTime;
  String? start;
  String? end;
  int? create;

  TodoModel({this.id,
      this.title,
      this.description,
      this.dateTime,
      this.isComplete=false,
      this.start,
      this.end,
      this.create,
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'title':title,
      'description':description,
      'isComplete':isComplete,
      'dateTime':dateTime,
      'start':start,
      'end':end,
      'create':create,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isComplete: map['isComplete'] as bool,
      dateTime: map['dateTime'] as int,
      start: map['start'] as String,
      end: map['end'] as String,
      create: map['create'] as int,
    );
  }
}