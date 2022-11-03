abstract class BaseApiServices {
  Future<dynamic> getPostApiResponse(String url, dynamic data, dynamic headers);

  /// Post a request contain multi files
  Future<dynamic> postMultipartApiWithMutiFiles(
    String url,
    String field,
    List<String> paths,
  );
}
