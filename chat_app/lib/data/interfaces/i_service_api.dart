import 'package:chat_app/data/response/base_response.dart';

abstract class IServiceAPI {
  Future<dynamic> getData({
    required dynamic data,
  });
  List<dynamic> convertDynamicToList({required BaseResponse value});
  dynamic convertDynamicToObject(dynamic value);
}
