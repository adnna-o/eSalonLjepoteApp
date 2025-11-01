import 'dart:convert';
import 'package:esalonljepote_mobile/models/klijenti.dart';
import 'package:esalonljepote_mobile/models/narudzba.dart';
import 'package:esalonljepote_mobile/models/proizvod.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// Bazna apstraktna klasa za sve providere.
/// Omogućava standardne CRUD operacije i jednostavno proširivanje.
abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint;
  late final String totalUrl;

  BaseProvider(String endpoint) : _endpoint = endpoint {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:44314/");
    totalUrl = "$_baseUrl$_endpoint";
  }

  /// Apstraktna metoda koju svaki provider mora implementirati
  /// kako bi znao kako pretvoriti JSON u model.
  T fromJson(dynamic data);

  /// GET metoda — vraća SearchResult<T> za zadani endpoint.
  Future<SearchResult<T>> get({dynamic filter}) async {
    var url = "$_baseUrl$_endpoint";

    if (filter != null) {
      final queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    final uri = Uri.parse(url);
    final headers = createHeaders();

    try {
      final response = await http.get(uri, headers: headers);

      if (isValidResponse(response)) {
        final data = jsonDecode(response.body);

        final result = SearchResult<T>();

        // podržava i listu i objekt s "result" poljem
        if (data is List) {
          for (dynamic item in data) {
            result.result.add(fromJson(item));
          }
          result.count = result.result.length;
        } else if (data is Map && data.containsKey('result')) {
          result.count = data['count'] ?? 0;
          for (dynamic item in data['result']) {
            result.result.add(fromJson(item));
          }
        }

        return result;
      } else {
        throw Exception("Unknown error");
      }
    } catch (e) {
      debugPrint("Error during GET request: $e");
      rethrow;
    }
  }

  /// PUT metoda — ažurira postojeći zapis.
  Future<T> update(int id, [dynamic request]) async {
    final uri = Uri.parse("$_baseUrl$_endpoint/$id");
    final headers = createHeaders();

    try {
      final jsonRequest = jsonEncode(request);
      final response = await http.put(uri, headers: headers, body: jsonRequest);

      if (isValidResponse(response)) {
        final data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        throw Exception("Unknown error");
      }
    } catch (e) {
      debugPrint("Error during PUT request: $e");
      rethrow;
    }
  }

  /// POST metoda — ubacuje novi zapis.
  Future<T> insert(dynamic request) async {
    final uri = Uri.parse("$_baseUrl$_endpoint");
    final headers = createHeaders();

    try {
      final jsonRequest = jsonEncode(request);
      debugPrint("POST $uri\nHeaders: $headers\nBody: $jsonRequest");

      final response = await http.post(uri, headers: headers, body: jsonRequest);

      debugPrint("Response: ${response.statusCode} ${response.body}");

      if (isValidResponse(response)) {
        final data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        throw Exception("Error: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      debugPrint("Error during POST request: $e");
      rethrow;
    }
  }

  /// DELETE metoda — briše entitet po ID-u.
  Future<T> delete(int? id) async {
    final uri = Uri.parse("$_baseUrl$_endpoint/$id");
    final headers = createHeaders();

    final response = await http.delete(uri, headers: headers);

    if (isValidResponse(response)) {
      final data = jsonDecode(response.body);
      notifyListeners();
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  /// Pretvara mapu parametara u query string.
  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      var newKey = key;
      if (inRecursion) {
        newKey = (key is int) ? '[$key]' : '.$key';
      }
      if (value is String ||
          value is int ||
          value is double ||
          value is bool) {
        query += '$prefix$newKey=${Uri.encodeComponent(value.toString())}';
      } else if (value is DateTime) {
        query += '$prefix$newKey=${value.toIso8601String()}';
      } else if (value is List || value is Map) {
        final mapped = (value is List) ? value.asMap() : value;
        mapped.forEach((k, v) {
          query += getQueryString({k: v},
              prefix: '$prefix$newKey', inRecursion: true);
        });
      }
    });
    return query;
  }

  /// Validira HTTP odgovor.
  bool isValidResponse(Response response) {
    if (response.statusCode < 300) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      debugPrint(response.body);
      throw Exception("Something bad happened, please try again");
    }
  }

  /// Kreira HTTP zaglavlja s Basic autentifikacijom.
  Map<String, String> createHeaders() {
    final username = Authorization.username ?? "";
    final password = Authorization.password ?? "";
    final basicAuth = "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    return {
      "Content-Type": "application/json",
      "Authorization": basicAuth,
    };
  }

  /// GET by ID
  Future<T> getById(int? id) async {
    final uri = Uri.parse("$_baseUrl$_endpoint/$id");
    final headers = createHeaders();

    final response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      final data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  /// GET klijenta prema korisnikId
  Future<Klijenti?> getByKorisnikId(int korisnikId) async {
    final uri = Uri.parse("$_baseUrl$_endpoint/GetByKorisnikId/$korisnikId");
    final headers = createHeaders();

    final response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      final data = jsonDecode(response.body);
      return Klijenti.fromJson(data);
    }
    return null;
  }

  /// GET preporučeni proizvodi
  Future<List<Proizvod>> fetchRecommendedProizvodi() async {
    try {
      final uri = Uri.parse('$totalUrl/preporuceni');
      final response = await http.get(uri, headers: createHeaders());

      if (isValidResponse(response)) {
        return (jsonDecode(response.body) as List)
            .map((item) => Proizvod.fromJson(item))
            .toList();
      } else {
        throw Exception('Invalid response: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching recommended proizvodi: $e');
      rethrow;
    }
  }

  /// GET izvještaj narudžbi
  Future<List<Narudzba>> getIzvjestajHistorijeNarudzbi(
      {Map<String, dynamic>? filter}) async {
    var url = "$_baseUrl$_endpoint/Izvjestaj";

    if (filter != null) {
      final queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    final uri = Uri.parse(url);
    final headers = createHeaders();

    try {
      final response = await http.get(uri, headers: headers);

      if (isValidResponse(response)) {
        final data = jsonDecode(response.body);
        final lista = <Narudzba>[];

        final resultList = data['result'] as List<dynamic>;
        for (dynamic item in resultList) {
          lista.add(fromJson(item) as Narudzba);
        }

        return lista;
      } else {
        throw Exception("Greška pri dohvatu izvještaja");
      }
    } catch (e) {
      debugPrint("Greška: $e");
      rethrow;
    }
  }

  /// Checkout iz korpe
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

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(bodyMap),
    );

    debugPrint('checkoutFromCart ${response.statusCode}: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      return data is int ? data : int.parse(data.toString());
    } else {
      throw Exception('Checkout failed: ${response.statusCode} ${response.body}');
    }
  }
}
