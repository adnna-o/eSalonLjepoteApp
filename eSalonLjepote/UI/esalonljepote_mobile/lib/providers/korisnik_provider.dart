import 'dart:convert';

import 'package:esalonljepote_mobile/models/korisnik.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';
import 'package:esalonljepote_mobile/utils/util.dart';
import 'package:http/http.dart' as http;

class KorisnikProvider extends BaseProvider<Korisnik> {
  Korisnik? _currentUser;
  KorisnikProvider() : super("Korisnik");

  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }

  Korisnik? get currentUser => _currentUser;

  Future<Korisnik?> login(String username, String password) async {
    try {
      var url = "$totalUrl/login";
      var uri = Uri.parse(url);

      var headers = createHeaders();
      var body = jsonEncode({'username': username, 'password': password});

      var response = await http.post(uri, headers: headers, body: body);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        Korisnik user = fromJson(data);
        _currentUser = user;
        return user;
      } else {
        print("Invalid credentials");
        return null;
      }
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
  }

  Future<Korisnik> Authenticate({dynamic filter}) async {
    var url = "$totalUrl/Authenticate";

    var uri = Uri.parse(url);

    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Korisnik user = fromJson(data) as Korisnik;
      _currentUser = user;
      return user;
    } else {
      throw Exception("Pogrešno korisničko ime ili lozinka");
    }
  }

  Future<bool> promeniLozinku(
      int korisnikId, String staraLozinka, String novaLozinka) async {
    var url = "$totalUrl/promeni-lozinku";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: createHeaders(),
        body: json.encode({
          'korisnikId': korisnikId,
          'staraLozinka': staraLozinka,
          'novaLozinka': novaLozinka,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to change password');
    }
  }

  List<Korisnik> items = [];

  Future<void> fetchAll() async {
    var result = await super.get();
    items = result.result;
  }

  Future<Korisnik?> getLoggedUser() async {
    try {
      var username = Authorization.username;
      if (username == null) return null;

      var result = await get(filter: {"username": username});
      if (result.result.isNotEmpty) {
        return result.result.first;
      }
      return null;
    } catch (e) {
      print("Greška pri dohvaćanju ulogovanog korisnika: $e");
      return null;
    }
  }

   Future<String?> registruj({
    required String ime,
    required String prezime,
    required String korisnickoIme,
    required String email,
    required String lozinka,
  }) async {
    final url = Uri.parse('$totalUrl');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "ime": ime,
          "prezime": prezime,
          "korisnickoIme": korisnickoIme,
          "email": email,
          "lozinka": lozinka,
        }),
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        return 'Greška: ${response.body}';
      }
    } catch (e) {
      return 'Došlo je do greške: $e';
    }
  }
}
