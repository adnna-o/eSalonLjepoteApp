// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salonLjepote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonLjepote _$SalonLjepoteFromJson(Map<String, dynamic> json) => SalonLjepote(
      salonLjepoteId: (json['salonLjepoteId'] as num?)?.toInt(),
      nazivSalona: json['nazivSalona'] as String?,
      adresa: json['adresa'] as String?,
      telefon: json['telefon'] as String?,
      email: json['email'] as String?,
      radnoVrijemeId: (json['radnoVrijemeId'] as num?)?.toInt(),
      administratorId: (json['administratorId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SalonLjepoteToJson(SalonLjepote instance) =>
    <String, dynamic>{
      'salonLjepoteId': instance.salonLjepoteId,
      'nazivSalona': instance.nazivSalona,
      'adresa': instance.adresa,
      'telefon': instance.telefon,
      'email': instance.email,
      'radnoVrijemeId': instance.radnoVrijemeId,
      'administratorId': instance.administratorId,
    };
