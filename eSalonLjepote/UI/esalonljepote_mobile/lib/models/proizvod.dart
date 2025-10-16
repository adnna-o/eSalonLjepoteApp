import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'proizvod.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Proizvod {
  Proizvod({
    this.proizvodId,
    this.nazivProizvoda,
    this.slika,
    this.cijena,
  });

  int? proizvodId;
  String? nazivProizvoda;
  String? slika;
  double? cijena;
  double? averageRating;


  factory Proizvod.fromJson(Map<String, dynamic> json) =>
      _$ProizvodFromJson(json);

  Map<String, dynamic> toJson() => _$ProizvodToJson(this);
}
