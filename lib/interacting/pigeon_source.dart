import 'package:pigeon/pigeon.dart';

class SearchRequest {
  final String query;
  SearchRequest({required this.query});
}

class SearchReply {
  final String result;
  SearchReply({required this.result});
}

@HostApi()
abstract class SearchApi {
  SearchReply search(SearchRequest request);
}

//network status
class NetWorkStatus {
  final String name;
  final String speed;
  final String carrierName;
  final String connectionType;

  NetWorkStatus({required this.name, required this.speed, required this.carrierName, required this.connectionType});
}

@HostApi()
abstract class NetworkApi {
  NetWorkStatus getNetworkInfo();
}

//ram

class RamResult {
  final double ramUsed;
  final double ramTotal;
  final double ramFree;
  final int pinStatus;
  final int tempStatus;
  RamResult({
    required this.ramUsed,
    required this.ramTotal,
    required this.ramFree,
    required this.pinStatus,
    required this.tempStatus,
  });
}

@HostApi()
abstract class RamApi {
  RamResult getRamInfo();
}

// dart run pigeon \
//   --input lib/interacting/pigeon_source.dart \
//   --dart_out lib/interacting/pigeon_generated.dart \
//   --kotlin_out android/app/src/main/kotlin/com/example/batterylevel/SearchPigeon.kt \
//   --swift_out ios/Runner/SearchPigeon.swift
