import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:esalonljepote_desktop/models/korisnik_uloga.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'narudzba.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Narudzba {
  Narudzba(
      {this.narudzbaId,
      this.korisnikId,
      this.proizvodId,
      this.placanjeId,
      this.datumNarudzbe,
      this.kolicinaProizvoda,
      this.iznosNarudzbe,
      this.korisnik = const [],
      this.proizvod = const [],

      });

  int? narudzbaId;
  int? korisnikId;
  int? proizvodId;
  int? placanjeId;
  DateTime? datumNarudzbe;
  int? kolicinaProizvoda;
  double? iznosNarudzbe;

  List<Korisnik> korisnik;
  List<Proizvod> proizvod;


  factory Narudzba.fromJson(Map<String, dynamic> json) =>
      _$NarudzbaFromJson(json);

  Map<String, dynamic> toJson() => _$NarudzbaToJson(this);
}
