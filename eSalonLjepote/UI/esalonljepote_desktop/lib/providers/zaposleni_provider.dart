import 'dart:convert';

import 'package:esalonljepote_desktop/models/uloga.dart';
import 'package:esalonljepote_desktop/models/zaposleni.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ZaposleniProvider extends BaseProvider<Zaposleni> {
  ZaposleniProvider() : super("Zaposleni");

  @override
  Zaposleni fromJson(data) {
    return Zaposleni.fromJson(data);
  }
}
