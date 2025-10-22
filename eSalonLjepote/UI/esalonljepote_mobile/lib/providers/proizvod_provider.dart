import 'dart:convert';
import 'package:esalonljepote_mobile/models/proizvod.dart';
import 'package:esalonljepote_mobile/providers/base_provider.dart';

import 'package:http/http.dart' as http;

class ProizvodProvider extends BaseProvider<Proizvod> {
  ProizvodProvider() : super("Proizvod");

  @override
  Proizvod fromJson(data) {
    return Proizvod.fromJson(data);
  }

  List<Proizvod> items = [];

  Future<void> fetchAll() async {
    var result = await super.get();
    items = result.result;
  }
}
