import 'dart:convert';

import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/uloga.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KlijentiProvider extends BaseProvider<Klijenti> {
  KlijentiProvider() : super("Klijenti");

  @override
  Klijenti fromJson(data) {
    return Klijenti.fromJson(data);
  }
}
