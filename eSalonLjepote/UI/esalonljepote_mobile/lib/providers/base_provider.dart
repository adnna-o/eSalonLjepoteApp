import 'dart:convert';
import 'package:esalonljepote_mobile/models/klijenti.dart';
import 'package:esalonljepote_mobile/models/narudzba.dart';
import 'package:esalonljepote_mobile/models/proizvod.dart';
import 'package:esalonljepote_mobile/models/recenzije.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/utils/util.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint;
  String? totalUrl;

  BaseProvider(String endpoint) : _endpoint = endpoint {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:44314/");
    totalUrl = "$_baseUrl$_endpoint";
  }
  Future<SearchResult<T>> get({dynamic filter}) async {
    var url = "$_baseUrl$_endpoint";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var response = await http.get(uri, headers: headers);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        var result = SearchResult<T>();
        result.count = data['count'];
        for (var item in data['result']) {
          result.result.add(fromJson(item));
        }
        return result;
      } else {
        throw Exception("Unknown error");
      }
    } catch (e) {
      print("Error during GET request: $e");
      rethrow;
    }
  }

  T fromJson(dynamic data);

  Future<T> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var jsonRequest = jsonEncode(request);
      var response = await http.put(uri, headers: headers, body: jsonRequest);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        throw Exception("Unknown error");
      }
    } catch (e) {
      print("Error during PUT request: $e");
      rethrow;
    }
  }

  Future<T> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var jsonRequest = jsonEncode(request);
      print("Request URL: $url");
      print("Request Headers: $headers");
      print("Request Body: $jsonRequest");

      var response = await http.post(uri, headers: headers, body: jsonRequest);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        throw Exception("Error: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Error during POST request: $e");
      rethrow;
    }
  }

  Future<T> delete(int? id) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    Response response = await http.delete(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      notifyListeners();
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        key = (key is int) ? '[$key]' : '.$key';
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = Uri.encodeComponent(value.toString());
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value as DateTime).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 300) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      print(response.body);
      throw Exception("Something bad happened, please try again");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    print("Passed credentials: $username, $password");

    String Basic = "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    return {
      "Content-Type": "application/json",
      "Authorization": Basic,
    };
  }

  Future<T> getById(int? id) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    Response response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<Klijenti?> getByKorisnikId(int korisnikId) async {
    var url = "$_baseUrl$_endpoint/GetByKorisnikId/$korisnikId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return Klijenti.fromJson(data);
    }
    return null;
  }

  Future<List<Proizvod>> fetchRecommendedProizvodi() async {
    try {
      final response = await http.get(Uri.parse('$totalUrl/preporuceni'),
          headers: createHeaders());
      if (isValidResponse(response)) {
        return (jsonDecode(response.body) as List)
            .map((item) => Proizvod.fromJson(item))
            .toList();
      } else {
        throw Exception('Invalid response: ${response.body}');
      }
    } catch (e) {
      print('Error fetching recommended doctors: $e');
      rethrow;
    }
  }

  Future<List<Narudzba>> getIzvjestajHistorijeNarudzbi(
      {Map<String, dynamic>? filter}) async {
    var url = "$_baseUrl$_endpoint/Izvjestaj";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var response = await http.get(uri, headers: headers);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        List<Narudzba> lista = [];
        var resultList = data['result'] as List<dynamic>;

        for (var item in resultList) {
          lista.add(fromJson(item) as Narudzba);
        }

        return lista;
      } else {
        throw Exception("Greška pri dohvatu izvještaja");
      }
    } catch (e) {
      print("Greška: $e");
      rethrow;
    }
  }

  Future<int> checkoutFromCart(
    int userId,
    String? paymentId, {
    int? proizvodId,
    DateTime? datumNarudzbe,
  }) async {
    final uri = Uri.parse('${_baseUrl}Narudzba/checkoutFromCart');
    final headers = createHeaders();

    final bodyMap = <String, dynamic>{
      "korisnikId": userId,
      "proizvodId": proizvodId,
      "paymentId": paymentId,
      if (datumNarudzbe != null)
        "datumNarudzbe": datumNarudzbe.toIso8601String(),
    };

    final resp = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(bodyMap),
    );

    debugPrint('checkoutFromCart ${resp.statusCode}: ${resp.body}');

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final data = jsonDecode(resp.body);
      return data is int ? data : int.parse(data.toString());
    } else {
      throw Exception('Checkout failed: ${resp.statusCode} ${resp.body}');
    }
  }
}
