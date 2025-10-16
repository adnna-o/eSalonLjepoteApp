import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'novosti.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Novosti {
  Novosti({
    this.novostiId,
    this.naziv,
    this.opisNovisti,
    this.datumObjave,
    this.korisnikId,
    this.aktivna,
  });

  int? novostiId;
  String? naziv;
  String? opisNovisti;
  DateTime? datumObjave;
  int? korisnikId;
  int? aktivna;

  factory Novosti.fromJson(Map<String, dynamic> json) =>
      _$NovostiFromJson(json);

  Map<String, dynamic> toJson() => _$NovostiToJson(this);
}
