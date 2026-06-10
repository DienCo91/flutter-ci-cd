import 'package:batterylevel/interacting/pigeon_generated.dart';

Future<void> onClick() async {
  SearchRequest request = SearchRequest(query: "test");

  SearchApi api = SearchApi();

  SearchReply result = await api.search(request);
  print('======result: ${result.result}');
}

Future<Map<String, num>> getRamStatus() async {
  RamApi api = RamApi();
  RamResult result = await api.getRamInfo();
  return {
    "ramUsed": result.ramUsed,
    "ramTotal": result.ramTotal,
    "ramFree": result.ramFree,
    "pinStatus": result.pinStatus,
    "tempStatus": result.tempStatus,
  };
}

Future<Map<String, String>> getNetworkInfo() async {
  NetworkApi api = NetworkApi();
  NetWorkStatus result = await api.getNetworkInfo();
  return {
    "name": result.name,
    "speed": result.speed,
    "carrierName": result.carrierName,
    "connectionType": result.connectionType,
  };
}
