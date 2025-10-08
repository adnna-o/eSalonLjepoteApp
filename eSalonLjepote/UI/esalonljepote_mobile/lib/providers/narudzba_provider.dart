import 'dart:convert';

import 'package:esalonljepote_mobile/models/narudzba.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';

import 'package:flutter/material.dart';
class NarudzbaProvider extends BaseProvider<Narudzba> {
  NarudzbaProvider() : super("Narudzba");

  @override
  Narudzba fromJson(data) {
    return Narudzba.fromJson(data);
  }

  // API poziv koji prima filtere i vraća listu narudžbi
  

}
