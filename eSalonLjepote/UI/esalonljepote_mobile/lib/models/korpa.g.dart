// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korpa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korpa _$KorpaFromJson(Map<String, dynamic> json) => Korpa(
      (json['korpaId'] as num?)?.toInt(),
      (json['klijentId'] as num?)?.toInt(),
      (json['proizvodId'] as num?)?.toInt(),
      (json['cijena'] as num?)?.toDouble(),
      (json['kolicina'] as num?)?.toInt(),
      json['proizvod'] == null
          ? null
          : Proizvod.fromJson(json['proizvod'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KorpaToJson(Korpa instance) => <String, dynamic>{
      'korpaId': instance.korpaId,
      'klijentId': instance.klijentId,
      'proizvodId': instance.proizvodId,
      'cijena': instance.cijena,
      'kolicina': instance.kolicina,
      'proizvod': instance.proizvod,
    };
