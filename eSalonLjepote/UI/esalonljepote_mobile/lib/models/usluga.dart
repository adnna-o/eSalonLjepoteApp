import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'usluga.g.dart';

@JsonSerializable()
class Usluga {
  int? uslugaId;
  String? nazivUsluge;
  double? cijena;
  String? trajanje;

  Usluga({this.uslugaId, this.nazivUsluge, this.cijena, this.trajanje});

  factory Usluga.fromJson(Map<String, dynamic> json) => _$UslugaFromJson(json);

  Map<String, dynamic> toJson() => _$UslugaToJson(this);
}
