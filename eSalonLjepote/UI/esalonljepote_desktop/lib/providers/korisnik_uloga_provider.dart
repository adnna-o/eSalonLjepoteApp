import 'dart:convert';

import 'package:esalonljepote_desktop/models/korisnik_uloga.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KorisnikUlogaProvider extends BaseProvider<KorisnikUloga> {
  KorisnikUlogaProvider() : super("KorisnikUloga");

  @override
  KorisnikUloga fromJson(data) {
    return KorisnikUloga.fromJson(data);
  }
}
