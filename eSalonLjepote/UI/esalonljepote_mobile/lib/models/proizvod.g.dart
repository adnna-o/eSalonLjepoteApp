// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proizvod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proizvod _$ProizvodFromJson(Map<String, dynamic> json) => Proizvod(
      proizvodId: (json['proizvodId'] as num?)?.toInt(),
      nazivProizvoda: json['nazivProizvoda'] as String?,
      slika: json['slika'] as String?,
      cijena: (json['cijena'] as num?)?.toDouble(),
    )..averageRating = (json['averageRating'] as num?)?.toDouble();

Map<String, dynamic> _$ProizvodToJson(Proizvod instance) => <String, dynamic>{
      'proizvodId': instance.proizvodId,
      'nazivProizvoda': instance.nazivProizvoda,
      'slika': instance.slika,
      'cijena': instance.cijena,
      'averageRating': instance.averageRating,
    };
