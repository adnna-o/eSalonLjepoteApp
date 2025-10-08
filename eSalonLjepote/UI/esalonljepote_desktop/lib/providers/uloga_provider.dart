import 'dart:convert';

import 'package:esalonljepote_desktop/models/uloga.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class UlogaProvider extends BaseProvider<Uloga> {
  UlogaProvider() : super("Uloga");

  @override
  Uloga fromJson(data) {
    return Uloga.fromJson(data);
  }
}
