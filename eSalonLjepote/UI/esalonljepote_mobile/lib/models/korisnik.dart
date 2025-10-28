import 'package:esalonljepote_mobile/models/korisnik_uloga.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'korisnik.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Korisnik {
  Korisnik(
      {this.korisnikId,
      this.ime,
      this.prezime,
      this.datumRodjenja,
      this.korisnickoIme,
      this.spol,
      this.email,
      this.lozinka,
      this.potvrdaLozinke,
      this.lozinkaHash,
      this.telefon,
      this.slika,
      this.korisnikUlogas = const []});

  int? korisnikId;
  String? ime;
  String? prezime;
  String? korisnickoIme;
  String? telefon;
  String? spol;
  String? email;
  String? lozinka;
  String? potvrdaLozinke;
  String? lozinkaHash;
  String? datumRodjenja;
  String? slika;
  List<KorisnikUloga> korisnikUlogas;

  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
