import 'dart:convert';

import 'package:esalonljepote_mobile/models/korisnik_uloga.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';

import 'package:http/http.dart' as http;

class KorisnikUlogaProvider extends BaseProvider<KorisnikUloga> {
  KorisnikUlogaProvider() : super("KorisnikUloga");

  @override
  KorisnikUloga fromJson(data) {
    return KorisnikUloga.fromJson(data);
  }
}
