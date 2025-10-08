import 'dart:convert';

import 'package:esalonljepote_desktop/models/galerija.dart';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class GalerijaProvider extends BaseProvider<Galerija> {
  GalerijaProvider() : super("Galerija");

  @override
  Galerija fromJson(data) {
    return Galerija.fromJson(data);
  }
}
