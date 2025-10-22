import 'dart:convert';

import 'package:esalonljepote_mobile/models/ocjene_proizvoda.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class OcjeneProizvodaProvider extends BaseProvider<OcjeneProizvoda> {
  OcjeneProizvodaProvider() : super("OcjeneProizvoda");

  @override
  OcjeneProizvoda fromJson(data) {
    return OcjeneProizvoda.fromJson(data);
  }
}
