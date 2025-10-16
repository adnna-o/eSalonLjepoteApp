import 'dart:convert';

import 'package:esalonljepote_mobile/models/klijenti.dart';
import 'package:esalonljepote_mobile/models/korisnik.dart';
import 'package:esalonljepote_mobile/models/zaposleni.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ZaposleniProvider extends BaseProvider<Zaposleni> {
  ZaposleniProvider() : super("Zaposleni");

  @override
  Zaposleni fromJson(data) {
    return Zaposleni.fromJson(data);
  }

  

}
