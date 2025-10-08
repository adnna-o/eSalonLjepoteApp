// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      datumRodjenja: json['datumRodjenja'] as String?,
      korisnickoIme: json['korisnickoIme'] as String?,
      spol: json['spol'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      potvrdaPassworda: json['potvrdaPassworda'] as String?,
      lozinkaHash: json['lozinkaHash'] as String?,
      telefon: json['telefon'] as String?,
      slika: json['slika'] as String?,
      korisnikUlogas: (json['korisnikUlogas'] as List<dynamic>?)
              ?.map((e) => KorisnikUloga.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'telefon': instance.telefon,
      'spol': instance.spol,
      'email': instance.email,
      'password': instance.password,
      'potvrdaPassworda': instance.potvrdaPassworda,
      'lozinkaHash': instance.lozinkaHash,
      'datumRodjenja': instance.datumRodjenja,
      'slika': instance.slika,
      'korisnikUlogas': instance.korisnikUlogas,
    };
