import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ny_times/data/network/base_api_services.dart';

import '../app_exceptions.dart';
import 'package:http/http.dart' as http;

class NetworkServices extends BaseApiServices {
  @override
  Future getMostPopularArticle(String url) async {
    dynamic responseJson;
    var queryParams = {"api-key": "${dotenv.env['API_KEY']}"};
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    try {
      http.Response response = await http.get(uri);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    log(response.body.toString());
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);

        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException('Sorry some error occured');
      default:
        throw FetchDataException(
            'Error accured while communicating with serverwith status code${response.statusCode}');
    }
  }
}

final netWorkProvider = Provider((ref) => NetworkServices());
