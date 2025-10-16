import 'dart:convert';

import 'package:esalonljepote_mobile/models/salonLjepote.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class SalonLjepoteProvider extends BaseProvider<SalonLjepote> {
  SalonLjepoteProvider() : super("SalonLjepote");

  @override
  SalonLjepote fromJson(data) {
    return SalonLjepote.fromJson(data);
  }
}
