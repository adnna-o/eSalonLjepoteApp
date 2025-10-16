import 'dart:convert';

import 'package:esalonljepote_mobile/models/termini.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class TerminiProvider extends BaseProvider<Termini> {
  TerminiProvider() : super("Termini");

  @override
  Termini fromJson(data) {
    return Termini.fromJson(data);
  }
}
