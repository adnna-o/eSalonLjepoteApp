// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usluga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usluga _$UslugaFromJson(Map<String, dynamic> json) => Usluga(
      uslugaId: (json['uslugaId'] as num?)?.toInt(),
      nazivUsluge: json['nazivUsluge'] as String?,
      cijena: (json['cijena'] as num?)?.toDouble(),
      trajanje: json['trajanje'] as String?,
    );

Map<String, dynamic> _$UslugaToJson(Usluga instance) => <String, dynamic>{
      'uslugaId': instance.uslugaId,
      'nazivUsluge': instance.nazivUsluge,
      'cijena': instance.cijena,
      'trajanje': instance.trajanje,
    };
