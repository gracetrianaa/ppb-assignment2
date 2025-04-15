import 'dart:convert';
import 'package:isar/isar.dart';
part 'task_model.g.dart';

@collection
class TaskModel {
  Id id = Isar.autoIncrement;
  late String title;
  late String status;
  DateTime? lastUpdated;

  TaskModel({
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
      'status': status,
      'lastUpdated' : lastUpdated?.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] as String,
      status: map['status'] as String? ?? 'In Progress',
      lastUpdated: map['lastUpdated'] != null ? DateTime.parse(map['lastUpdated']) : null,
      )..id = map['id'] as int;
  }
  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}



