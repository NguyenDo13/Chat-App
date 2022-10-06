class Environment {
  String baseURL = 'http://192.168.1.4:5000/api/';
  Environment({required bool isServerDev}) {
    if (isServerDev) {
      baseURL = 'http://192.168.1.4:5000/api/';
    } else {
      baseURL = 'http://192.168.1.4:5000/public/api/';
    }
  }
}
