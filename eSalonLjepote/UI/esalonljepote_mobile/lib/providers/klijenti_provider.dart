import 'dart:convert';

import 'package:esalonljepote_mobile/models/klijenti.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KlijentiProvider extends BaseProvider<Klijenti> {
  KlijentiProvider() : super("Klijenti");

  @override
  Klijenti fromJson(data) {
    return Klijenti.fromJson(data);
  }

    List<Klijenti> items = [];

  Future<void> fetchAll() async {
    var result = await super.get();
    items = result.result;
  }
}
