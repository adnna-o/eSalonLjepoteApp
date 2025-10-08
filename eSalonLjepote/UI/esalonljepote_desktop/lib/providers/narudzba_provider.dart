import 'dart:convert';

import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/narudzba.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/uloga.dart';
import 'package:esalonljepote_desktop/providers/base_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class NarudzbaProvider extends BaseProvider<Narudzba> {
  NarudzbaProvider() : super("Narudzba");

  @override
  Narudzba fromJson(data) {
    return Narudzba.fromJson(data);
  }

  // API poziv koji prima filtere i vraća listu narudžbi
  

}
