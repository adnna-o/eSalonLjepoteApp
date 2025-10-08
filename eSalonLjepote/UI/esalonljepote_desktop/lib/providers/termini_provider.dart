import 'dart:convert';

import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/uloga.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class TerminiProvider extends BaseProvider<Termini> {
  TerminiProvider() : super("Termini");

  @override
  Termini fromJson(data) {
    return Termini.fromJson(data);
  }
}
