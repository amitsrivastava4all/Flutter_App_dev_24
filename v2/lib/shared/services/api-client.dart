// Network Call
import 'package:dio/dio.dart';

Dio dio = Dio();
getApi(String URL) async {
  final response = await dio.get(URL);
  print("************ Response *************");
  print(response.runtimeType);

  final state = (response.data['features'][0]['properties']['state']);
  return state;
}
