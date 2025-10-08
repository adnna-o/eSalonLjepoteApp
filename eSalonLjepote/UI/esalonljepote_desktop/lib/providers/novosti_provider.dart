import 'dart:convert';

import 'package:esalonljepote_desktop/models/galerija.dart';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/novosti.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class NovostiProvider extends BaseProvider<Novosti> {
  NovostiProvider() : super("Novosti");

  @override
  Novosti fromJson(data) {
    return Novosti.fromJson(data);
  }
}
