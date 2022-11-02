abstract class BaseApiServices {
  Future<dynamic> getPostApiResponse(String url, dynamic data, dynamic headers);

  Future<dynamic> postMultipartApiResponse(
    String url,
    String field,
    String path,
  );
}
