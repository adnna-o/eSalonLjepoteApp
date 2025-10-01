// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novosti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Novosti _$NovostiFromJson(Map<String, dynamic> json) => Novosti(
      novostiId: (json['novostiId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      opisNovosti: json['opisNovosti'] as String?,
      datumObjave: json['datumObjave'] == null
          ? null
          : DateTime.parse(json['datumObjave'] as String),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      aktivna: (json['aktivna'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NovostiToJson(Novosti instance) => <String, dynamic>{
      'novostiId': instance.novostiId,
      'naziv': instance.naziv,
      'opisNovosti': instance.opisNovosti,
      'datumObjave': instance.datumObjave?.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'aktivna': instance.aktivna,
    };
