import 'dart:convert';

import 'package:esalonljepote_mobile/models/novosti.dart';
import 'package:esalonljepote_mobile/models/recenzije.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class RecenzijaProvider extends BaseProvider<Recenzije> {
  RecenzijaProvider() : super("Recenzije");

  @override
  Recenzije fromJson(data) {
    return Recenzije.fromJson(data);
  }
}
