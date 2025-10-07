// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placanje.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Placanje _$PlacanjeFromJson(Map<String, dynamic> json) => Placanje(
      placanjeId: (json['placanjeId'] as num?)?.toInt(),
      nacinPlacanja: json['nacinPlacanja'] as String?,
    );

Map<String, dynamic> _$PlacanjeToJson(Placanje instance) => <String, dynamic>{
      'placanjeId': instance.placanjeId,
      'nacinPlacanja': instance.nacinPlacanja,
    };
