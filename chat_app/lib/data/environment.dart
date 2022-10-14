class Environment {
  String baseURL = 'http://192.168.1.104:5000/';
  String urlServer = 'http://192.168.1.104:5000';
  Environment({required bool isServerDev}) {
    if (isServerDev) {
      baseURL = '${baseURL}api/';
    } else {
      baseURL = '${baseURL}public/api/';
    }
  }
}
