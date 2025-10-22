import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'ocjene_proizvoda.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class OcjeneProizvoda {
  OcjeneProizvoda({
    this.ocjeneProizvodaId,
    this.korisnikId,
    this.proizvodId,
    this.ocjena,
    this.opis,
  });

  int? ocjeneProizvodaId;
  int? korisnikId;
  int? proizvodId;
  String? opis;
  int? ocjena;

  factory OcjeneProizvoda.fromJson(Map<String, dynamic> json) =>
      _$OcjeneProizvodaFromJson(json);

  Map<String, dynamic> toJson() => _$OcjeneProizvodaToJson(this);
}
