// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uloga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uloga _$UlogaFromJson(Map<String, dynamic> json) => Uloga(
      ulogaId: (json['ulogaId'] as num?)?.toInt(),
      nazivUloge: json['nazivUloge'] as String?,
    );

Map<String, dynamic> _$UlogaToJson(Uloga instance) => <String, dynamic>{
      'ulogaId': instance.ulogaId,
      'nazivUloge': instance.nazivUloge,
    };
