import 'dart:convert';

import 'package:esalonljepote_desktop/models/administrator.dart';
import 'package:esalonljepote_desktop/models/galerija.dart';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/placanje.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class PlacanjeProvider extends BaseProvider<Placanje> {
  PlacanjeProvider() : super("Placanje");

  @override
  Placanje fromJson(data) {
    return Placanje.fromJson(data);
  }
}
