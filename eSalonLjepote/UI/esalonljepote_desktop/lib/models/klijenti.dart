import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:esalonljepote_desktop/models/korisnik_uloga.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'klijenti.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Klijenti {
  Klijenti({this.klijentId, this.korisnikId, this.korisnik = const []});

  int? klijentId;
  int? korisnikId;
  List<Korisnik> korisnik;

  factory Klijenti.fromJson(Map<String, dynamic> json) =>
      _$KlijentiFromJson(json);

  Map<String, dynamic> toJson() => _$KlijentiToJson(this);
}
