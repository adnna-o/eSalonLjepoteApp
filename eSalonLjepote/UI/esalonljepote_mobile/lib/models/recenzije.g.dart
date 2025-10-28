// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenzije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recenzije _$RecenzijeFromJson(Map<String, dynamic> json) => Recenzije(
      recenzijeId: (json['recenzijeId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      opisRecenzije: json['opisRecenzije'] as String?,
      ocjena: (json['ocjena'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecenzijeToJson(Recenzije instance) => <String, dynamic>{
      'recenzijeId': instance.recenzijeId,
      'korisnikId': instance.korisnikId,
      'opisRecenzije': instance.opisRecenzije,
      'ocjena': instance.ocjena,
    };
