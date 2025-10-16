import 'dart:convert';

import 'package:esalonljepote_mobile/models/novosti.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class NovostiProvider extends BaseProvider<Novosti> {
  NovostiProvider() : super("Novosti");

  @override
  Novosti fromJson(data) {
    return Novosti.fromJson(data);
  }
}
