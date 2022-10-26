import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/interfaces/i_service_api.dart';
import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/response/base_response.dart';
import 'package:chat_app/data/models/error.dart';
import '../network/base_api_service.dart';
import '../network/network_api_service.dart';

class ChatRepository extends IServiceAPI {
  String urlEndPointFindAUser = "chat/findAUser";
  String urlEndPointGetRooms = "chat/getRooms";
  String urlEndPointGetFriendRequests = "chat/getFriendRequests";
  String urlEndPointRemoveRequest= "chat/removeRequest";

  final BaseApiServices apiServices = NetworkApiService();
  late Environment environment;

  ChatRepository({required this.environment}) {
    urlEndPointFindAUser = environment.baseURL + urlEndPointFindAUser;
    urlEndPointGetRooms = environment.baseURL + urlEndPointGetRooms;
    urlEndPointGetFriendRequests = environment.baseURL + urlEndPointGetFriendRequests;
    urlEndPointRemoveRequest = environment.baseURL + urlEndPointRemoveRequest;
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

  Future<BaseResponse?> findAUser({required data}) async {
    try {
      final response = await apiServices.getPostApiResponse(
        urlEndPointFindAUser,
        data,
        {'Content-Type': 'application/json'},
      );
      return BaseResponse.fromJson(response);
    } on Exception catch (_) {
      return null;
    }
  }

   Future<BaseResponse?> getRooms({required data}) async {
    try {
      final response = await apiServices.getPostApiResponse(
        urlEndPointGetRooms,
        data,
        {'Content-Type': 'application/json'},
      );
      return BaseResponse.fromJson(response);
    } on Exception catch (_) {
      return null;
    }
  }
  Future<BaseResponse?> getFriendRequests({required data}) async {
    try {
      final response = await apiServices.getPostApiResponse(
        urlEndPointGetFriendRequests,
        data,
        {'Content-Type': 'application/json'},
      );
      return BaseResponse.fromJson(response);
    } on Exception catch (_) {
      return null;
    }
  }
    Future<BaseResponse?> removeRequest({required data}) async {
    try {
      final response = await apiServices.getPostApiResponse(
        urlEndPointRemoveRequest,
        data,
        {'Content-Type': 'application/json'},
      );
      return BaseResponse.fromJson(response);
    } on Exception catch (_) {
      return null;
    }
  }
}
