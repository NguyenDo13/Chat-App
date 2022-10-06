import 'package:chat_app/data/response/base_response.dart';

abstract class IServiceAPI {
  Future<dynamic> getDataRegister({required dynamic data, required dynamic header});

  Future<dynamic> getDataLogin({required dynamic data, required dynamic header});

  Future<dynamic> getDataLoginWithAccessToken({required dynamic data, required dynamic header});

  List<dynamic> convertDynamicToList({required BaseResponse value});

  dynamic convertDynamicToObject(dynamic value);
}
