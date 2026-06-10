import 'package:json_annotation/json_annotation.dart';

part 'dog.g.dart';

@JsonSerializable(createJsonSchema: true)
class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({required this.id, required this.name, required this.age});

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);

  Map<String, dynamic> toJson() => _$DogToJson(this);

  static const jsonSchema = _$DogJsonSchema;

  Dog copyWith({int? id, String? name, int? age}) {
    return Dog(id: id ?? this.id, name: name ?? this.name, age: age ?? this.age);
  }
}
