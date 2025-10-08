import 'dart:convert';

import 'package:esalonljepote_desktop/models/administrator.dart';
import 'package:esalonljepote_desktop/models/galerija.dart';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ProizvodProvider extends BaseProvider<Proizvod> {
  ProizvodProvider() : super("Proizvod");

  @override
  Proizvod fromJson(data) {
    return Proizvod.fromJson(data);
  }
}
