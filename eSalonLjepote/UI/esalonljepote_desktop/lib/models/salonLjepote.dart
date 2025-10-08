import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'salonLjepote.g.dart';

@JsonSerializable()
class SalonLjepote {
  int? salonLjepoteId;
  String? nazivSalona;
  String? adresa;
  String? telefon;
  String? email;
  int? radnoVrijemeId;
  int? administratorId;

  SalonLjepote(
      {this.salonLjepoteId,
      this.nazivSalona,
      this.adresa,
      this.telefon,
      this.email,
      this.radnoVrijemeId,
      this.administratorId});

  factory SalonLjepote.fromJson(Map<String, dynamic> json) =>
      _$SalonLjepoteFromJson(json);

  Map<String, dynamic> toJson() => _$SalonLjepoteToJson(this);
}
