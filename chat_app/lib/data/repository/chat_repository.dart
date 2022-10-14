import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/interfaces/i_service_api.dart';
import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/response/base_response.dart';
import 'package:chat_app/data/models/error.dart';
import '../network/base_api_service.dart';
import '../network/network_api_service.dart';

class ChatRepository extends IServiceAPI{
  String urlEndPointGetInfoUser = "auth/getInfoUserByID";

  final BaseApiServices apiServices = NetworkApiService();
  late Environment environment;

  ChatRepository({required this.environment}) {
    urlEndPointGetInfoUser = environment.baseURL + urlEndPointGetInfoUser;
  }

  @override
  List convertDynamicToList({required BaseResponse value}) {
    throw UnimplementedError();
  }

  @override
  User convertDynamicToObject(value) {
    return User.fromJson(value);
  }

  @override
  Error convertDynamicToError(value) {
    return Error.fromJson(value);
  }

  Future<BaseResponse?> getInfoUserById({required data, required header}) async {
    try {
      final response = await apiServices.getPostApiResponse(
        urlEndPointGetInfoUser,
        data,
        header,
      );
      return BaseResponse.fromJson(response);
    } on Exception catch (_) {
      return null;
    }
  }
}
