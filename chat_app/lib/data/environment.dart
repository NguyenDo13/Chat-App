class Environment {
  String baseURL = 'http://192.168.1.104:5000/api/';
  String urlServer = 'http://192.168.1.104:5000';
  Environment({required bool isServerDev}) {
    if (isServerDev) {
      baseURL = 'http://192.168.1.104:5000/api/';
    } else {
      baseURL = 'http://192.168.1.104:5000/public/api/';
    }
  }
}
