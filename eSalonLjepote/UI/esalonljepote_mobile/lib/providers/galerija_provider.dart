import 'dart:convert';

import 'package:esalonljepote_mobile/models/galerija.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class GalerijaProvider extends BaseProvider<Galerija> {
  GalerijaProvider() : super("Galerija");

  @override
  Galerija fromJson(data) {
    return Galerija.fromJson(data);
  }

 
}
