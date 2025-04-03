import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:devotions_app/core/errors/exceptions.dart';
import 'package:devotions_app/shared/utils/api_headers.dart';
import 'package:http/http.dart' show Client, Response;

class HttpUtils {
  static Future<Response> get(Uri url, Client client) async {
    var authHeaders = await ApiHeaders.headers;
    dev.log("🔌 HTTP GET Request: $url");
    dev.log("🔌 Headers: ${authHeaders.toString()}");

    var response = await client.get(url, headers: {...authHeaders});
    return response;
  }

  static Future<Response> post(
    Uri url,
    Client client, {
    Map<String?, dynamic>? body,
    Map<String, dynamic> headers = const {},
  }) async {
    var authHeaders = await ApiHeaders.headers;
    String? requestBody;

    if (body != null) {
      requestBody = jsonEncode(body);
    }

    dev.log("🔌 HTTP POST Request: $url");
    dev.log("🔌 Headers: ${authHeaders.toString()} + ${headers.toString()}");
    if (requestBody != null) {
      dev.log(
        "🔌 Body: ${requestBody.substring(0, requestBody.length > 100 ? 100 : requestBody.length)}...",
      );
    }

    try {
      var response = await client.post(
        url,
        headers: {...authHeaders, ...headers},
        body: requestBody,
      );

      return response;
    } on HttpException {
      throw ServerException(
        'Unable to connect to services. Please try again later.',
      );
    }
  }

  static Future<Response> put(
    Uri url,
    Client client, {
    Map<String?, dynamic>? body,
  }) async {
    var authHeaders = await ApiHeaders.headers;
    String? requestBody;

    if (body != null) {
      requestBody = jsonEncode(body);
    }

    dev.log("🔌 HTTP PUT Request: $url");
    dev.log("🔌 Headers: ${authHeaders.toString()}");
    if (requestBody != null) {
      dev.log(
        "🔌 Body: ${requestBody.substring(0, requestBody.length > 100 ? 100 : requestBody.length)}...",
      );
    }

    var response = await client.put(
      url,
      headers: authHeaders,
      body: requestBody,
    );

    return response;
  }

  static Future<Response> putAll(Uri url, Client client, {dynamic body}) async {
    var authHeaders = await ApiHeaders.headers;
    String? requestBody;

    if (body != null) {
      requestBody = jsonEncode(body);
    }

    var response = await client.put(
      url,
      headers: authHeaders,
      body: requestBody,
    );

    return response;
  }

  static Future<Response> patch(
    Uri url,
    Client client, {
    Map<String?, dynamic>? body,
  }) async {
    var authHeaders = await ApiHeaders.headers;
    String? requestBody;

    if (body != null) {
      requestBody = jsonEncode(body);
    }

    var response = await client.patch(
      url,
      headers: authHeaders,
      body: requestBody,
    );

    return response;
  }

  static Future<Response> delete(
    Uri url,
    Client client, {
    Map<String?, dynamic>? body,
  }) async {
    var authHeaders = await ApiHeaders.headers;
    String? requestBody;

    if (body != null) {
      requestBody = jsonEncode(body);
    }

    dev.log("🔌 HTTP DELETE Request: $url");
    dev.log("🔌 Headers: ${authHeaders.toString()}");

    var response = await client.delete(
      url,
      headers: authHeaders,
      body: requestBody,
    );

    return response;
  }
}
