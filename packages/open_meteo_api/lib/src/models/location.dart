import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  const Location({required this.id, required this.name, required this.latitude, required this.longitude});

  final int id;
  final String name;
  final double latitude;
  final double longitude;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Location copyWith({int? id, String? name, double? latitude, double? longitude}) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
