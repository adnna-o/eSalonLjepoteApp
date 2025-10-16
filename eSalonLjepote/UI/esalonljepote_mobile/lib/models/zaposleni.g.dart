// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zaposleni.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zaposleni _$ZaposleniFromJson(Map<String, dynamic> json) => Zaposleni(
      zaposleniId: (json['zaposleniId'] as num?)?.toInt(),
      datumZaposlenja: json['datumZaposlenja'] == null
          ? null
          : DateTime.parse(json['datumZaposlenja'] as String),
      zanimanje: json['zanimanje'] as String?,
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ZaposleniToJson(Zaposleni instance) => <String, dynamic>{
      'zaposleniId': instance.zaposleniId,
      'datumZaposlenja': instance.datumZaposlenja?.toIso8601String(),
      'zanimanje': instance.zanimanje,
      'korisnikId': instance.korisnikId,
    };
