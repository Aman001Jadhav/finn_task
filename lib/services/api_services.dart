import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../constants/api_urls.dart';
import '../helper/toaster.dart';

class ApiService {
  Future<dynamic> getApiCall(String endPoint) async {
    // try {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ShowToaster.showToaster("No Internet Connection");
      return "";
    }
    dynamic headers;

    headers = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(endPoint);
    var response = await http.get(url, headers: headers);
    print(url);
    if (response.statusCode != 500) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse["status"]);
      print("1111111111111");
      // if (jsonResponse["status"] == "success" ||
      //     jsonResponse["status"] == true) {
      return response;
      //   } else if (jsonResponse["message"] == "Invalid token") {
      //   } else {
      //     ShowToaster.showToaster(jsonResponse["message"]);
      //     return "";
      //   }
      // } else {
      //   ShowToaster.showToaster(
      //       "We are performing some technical tasks at our end. Kindly try again in some time.");
      //   return "";
      // }
      //}
      // catch (e) {
      //   log(e.toString());
    }
  }
}
