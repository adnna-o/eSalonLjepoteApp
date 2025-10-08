import 'dart:convert';

import 'package:esalonljepote_desktop/models/salonLjepote.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/uloga.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class SalonLjepoteProvider extends BaseProvider<SalonLjepote> {
  SalonLjepoteProvider() : super("SalonLjepote");

  @override
  SalonLjepote fromJson(data) {
    return SalonLjepote.fromJson(data);
  }
}
