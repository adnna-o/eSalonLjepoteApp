import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'zaposleni.g.dart';

@JsonSerializable()
class Zaposleni {
  int? zaposleniId;
  DateTime? datumZaposlenja;
  String? zanimanje;
  int? korisnikId;

  Zaposleni(
      {this.zaposleniId,
      this.datumZaposlenja,
      this.zanimanje,
      this.korisnikId});

  factory Zaposleni.fromJson(Map<String, dynamic> json) =>
      _$ZaposleniFromJson(json);

  Map<String, dynamic> toJson() => _$ZaposleniToJson(this);
}
