// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenzije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recenzije _$RecenzijeFromJson(Map<String, dynamic> json) => Recenzije(
      recenzijeId: (json['recenzijeId'] as num?)?.toInt(),
      klijentId: (json['klijentId'] as num?)?.toInt(),
      zaposleniId: (json['zaposleniId'] as num?)?.toInt(),
      uslugaId: (json['uslugaId'] as num?)?.toInt(),
      proizvodId: (json['proizvodId'] as num?)?.toInt(),
      opisRecenzije: json['opisRecenzije'] as String?,
      ocjena: (json['ocjena'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecenzijeToJson(Recenzije instance) => <String, dynamic>{
      'recenzijeId': instance.recenzijeId,
      'klijentId': instance.klijentId,
      'zaposleniId': instance.zaposleniId,
      'uslugaId': instance.uslugaId,
      'proizvodId': instance.proizvodId,
      'opisRecenzije': instance.opisRecenzije,
      'ocjena': instance.ocjena,
    };
