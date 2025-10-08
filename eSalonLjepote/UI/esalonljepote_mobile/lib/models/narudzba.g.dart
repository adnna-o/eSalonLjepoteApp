// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Narudzba _$NarudzbaFromJson(Map<String, dynamic> json) => Narudzba(
      narudzbaId: (json['narudzbaId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      proizvodId: (json['proizvodId'] as num?)?.toInt(),
      placanjeId: (json['placanjeId'] as num?)?.toInt(),
      datumNarudzbe: json['datumNarudzbe'] == null
          ? null
          : DateTime.parse(json['datumNarudzbe'] as String),
      kolicinaProizvoda: (json['kolicinaProizvoda'] as num?)?.toInt(),
      iznosNarudzbe: (json['iznosNarudzbe'] as num?)?.toDouble(),
      korisnik: (json['korisnik'] as List<dynamic>?)
              ?.map((e) => Korisnik.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      proizvod: (json['proizvod'] as List<dynamic>?)
              ?.map((e) => Proizvod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NarudzbaToJson(Narudzba instance) => <String, dynamic>{
      'narudzbaId': instance.narudzbaId,
      'korisnikId': instance.korisnikId,
      'proizvodId': instance.proizvodId,
      'placanjeId': instance.placanjeId,
      'datumNarudzbe': instance.datumNarudzbe?.toIso8601String(),
      'kolicinaProizvoda': instance.kolicinaProizvoda,
      'iznosNarudzbe': instance.iznosNarudzbe,
      'korisnik': instance.korisnik,
      'proizvod': instance.proizvod,
    };
