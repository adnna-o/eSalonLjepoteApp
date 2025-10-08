import 'dart:convert';

import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/uloga.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class UslugaProvider extends BaseProvider<Usluga> {
  UslugaProvider() : super("Usluga");

  @override
  Usluga fromJson(data) {
    return Usluga.fromJson(data);
  }
}
