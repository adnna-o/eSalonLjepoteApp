import 'dart:convert';

import 'package:esalonljepote_mobile/models/proizvod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korpa.g.dart';

@JsonSerializable()
class Korpa {
  int? korpaId;
  int? klijentId;
  int? proizvodId;
  double? cijena;
  int? kolicina;
  Proizvod? proizvod;

  Korpa(this.korpaId, this.klijentId, this.proizvodId, this.cijena, this.kolicina,
       this.proizvod);

  factory Korpa.fromJson(Map<String, dynamic> json) => _$KorpaFromJson(json);

  Map<String, dynamic> toJson() => _$KorpaToJson(this);
}
