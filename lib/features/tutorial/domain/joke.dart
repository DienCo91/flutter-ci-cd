import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'joke.g.dart';

@JsonSerializable(createJsonSchema: true)
class Joke extends Equatable {
  final String type;
  final String setup;
  final String punchline;
  final int id;

  const Joke({
    required this.type,
    required this.setup,
    required this.punchline,
    required this.id,
  });

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);

  Map<String, dynamic> toJson() => _$JokeToJson(this);

  static const jsonSchema = _$JokeJsonSchema;

  @override
  List<Object?> get props => [type, setup, punchline, id];
}
