// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termini.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termini _$TerminiFromJson(Map<String, dynamic> json) => Termini(
      terminId: (json['terminId'] as num?)?.toInt(),
      klijentId: (json['klijentId'] as num?)?.toInt(),
      uslugaId: (json['uslugaId'] as num?)?.toInt(),
      zaposleniId: (json['zaposleniId'] as num?)?.toInt(),
      datumTermina: json['datumTermina'] == null
          ? null
          : DateTime.parse(json['datumTermina'] as String),
      vrijemeTermina: json['vrijemeTermina'] as String?,
    );

Map<String, dynamic> _$TerminiToJson(Termini instance) => <String, dynamic>{
      'terminId': instance.terminId,
      'klijentId': instance.klijentId,
      'uslugaId': instance.uslugaId,
      'zaposleniId': instance.zaposleniId,
      'datumTermina': instance.datumTermina?.toIso8601String(),
      'vrijemeTermina': instance.vrijemeTermina,
    };
