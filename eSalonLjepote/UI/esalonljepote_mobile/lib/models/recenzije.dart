import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'recenzije.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Recenzije {
  Recenzije({
    this.recenzijeId,
    this.korisnikId,
    this.opisRecenzije,
    this.ocjena,
  });

  int? recenzijeId;
  int? korisnikId;
  String? opisRecenzije;
  int? ocjena;

  factory Recenzije.fromJson(Map<String, dynamic> json) =>
      _$RecenzijeFromJson(json);

  Map<String, dynamic> toJson() => _$RecenzijeToJson(this);
}
