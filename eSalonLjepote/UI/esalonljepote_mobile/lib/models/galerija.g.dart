// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'galerija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Galerija _$GalerijaFromJson(Map<String, dynamic> json) => Galerija(
      galerijaId: (json['galerijaId'] as num?)?.toInt(),
      slika: json['slika'] as String?,
      administratorId: (json['administratorId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GalerijaToJson(Galerija instance) => <String, dynamic>{
      'galerijaId': instance.galerijaId,
      'slika': instance.slika,
      'administratorId': instance.administratorId,
    };
