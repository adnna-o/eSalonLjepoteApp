// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjene_proizvoda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcjeneProizvoda _$OcjeneProizvodaFromJson(Map<String, dynamic> json) =>
    OcjeneProizvoda(
      ocjeneProizvodaId: (json['ocjeneProizvodaId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      proizvodId: (json['proizvodId'] as num?)?.toInt(),
      ocjena: (json['ocjena'] as num?)?.toInt(),
      opis: json['opis'] as String?,
    );

Map<String, dynamic> _$OcjeneProizvodaToJson(OcjeneProizvoda instance) =>
    <String, dynamic>{
      'ocjeneProizvodaId': instance.ocjeneProizvodaId,
      'korisnikId': instance.korisnikId,
      'proizvodId': instance.proizvodId,
      'opis': instance.opis,
      'ocjena': instance.ocjena,
    };
