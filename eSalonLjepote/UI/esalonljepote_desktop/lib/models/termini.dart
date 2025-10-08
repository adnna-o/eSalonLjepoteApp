import 'package:json_annotation/json_annotation.dart';
import 'package:esalonljepote_desktop/models/korisnik_uloga.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'termini.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Termini {
  Termini({
    this.terminId,
    this.klijentId,
    this.uslugaId,
    this.zaposleniId,
    this.datumTermina,
    this.vrijemeTermina,
  });

  int? terminId;
  int? klijentId;
  int? uslugaId;
  int? zaposleniId;
  DateTime? datumTermina;
  String? vrijemeTermina;

  factory Termini.fromJson(Map<String, dynamic> json) =>
      _$TerminiFromJson(json);

  Map<String, dynamic> toJson() => _$TerminiToJson(this);
}
