// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'administrator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Administrator _$AdministratorFromJson(Map<String, dynamic> json) =>
    Administrator(
      administratorId: (json['administratorId'] as num?)?.toInt(),
      datumZaposlenja: json['datumZaposlenja'] == null
          ? null
          : DateTime.parse(json['datumZaposlenja'] as String),
      opisPosla: json['opisPosla'] as String?,
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdministratorToJson(Administrator instance) =>
    <String, dynamic>{
      'administratorId': instance.administratorId,
      'datumZaposlenja': instance.datumZaposlenja?.toIso8601String(),
      'opisPosla': instance.opisPosla,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
    };
