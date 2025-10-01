import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:esalonljepote_desktop/models/korisnik_uloga.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'galerija.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Galerija {
  Galerija({
    this.galerijaId,
    this.slika,
    this.administratorId,
  });

  int? galerijaId;
  String? slika;
  int? administratorId;

  factory Galerija.fromJson(Map<String, dynamic> json) =>
      _$GalerijaFromJson(json);

  Map<String, dynamic> toJson() => _$GalerijaToJson(this);
}
