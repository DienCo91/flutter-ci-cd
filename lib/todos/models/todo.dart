import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable(createJsonSchema: true)
class Todo {
  final String? title, id, createdAt;
  final bool? isComplete;

  Todo({this.title, this.id, this.isComplete, this.createdAt});

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  static const jsonSchema = _$TodoJsonSchema;

  Todo copyWith({String? id, String? title, String? createdAt, bool? isComplete}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isComplete: isComplete ?? this.isComplete,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
