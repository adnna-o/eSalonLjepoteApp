import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:esalonljepote_desktop/models/korisnik_uloga.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'administrator.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Administrator {
  Administrator({
    this.administratorId,
    this.datumZaposlenja,
    this.opisPosla,
    this.korisnikId,
    this.korisnik,
  });

  int? administratorId;
  DateTime? datumZaposlenja;
  String? opisPosla;
  int? korisnikId;
  Korisnik? korisnik;

  factory Administrator.fromJson(Map<String, dynamic> json) =>
      _$AdministratorFromJson(json);

  Map<String, dynamic> toJson() => _$AdministratorToJson(this);
}
