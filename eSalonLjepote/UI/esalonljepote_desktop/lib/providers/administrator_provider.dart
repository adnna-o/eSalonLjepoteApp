import 'dart:convert';

import 'package:esalonljepote_desktop/models/administrator.dart';
import 'package:esalonljepote_desktop/models/galerija.dart';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class AdministratorProvider extends BaseProvider<Administrator> {
  AdministratorProvider() : super("Administrator");

  @override
  Administrator fromJson(data) {
    return Administrator.fromJson(data);
  }
}
