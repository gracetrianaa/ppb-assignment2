import 'dart:convert';

class TaskModel {
  final String id;
  String title;
  String status;
  DateTime? lastUpdated;

  TaskModel({
    required this.id,
    required this.title,
    this.status = "In Progress",
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  @override
  String toString() => 'TaskModel(id: $id, title: $title, status: $status, lastUpdated: $lastUpdated)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'lastUpdated' : lastUpdated?.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      status: map['status'] as String? ?? 'In Progress',
      lastUpdated: map['lastUpdated'] != null ? DateTime.parse(map['lastUpdated']) : null,
    );
  }
  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}



