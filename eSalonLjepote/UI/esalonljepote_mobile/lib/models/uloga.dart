import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'uloga.g.dart';

@JsonSerializable()
class Uloga {
  int? ulogaId;
  String? nazivUloge;

  Uloga({this.ulogaId, this.nazivUloge});

  factory Uloga.fromJson(Map<String, dynamic> json) => _$UlogaFromJson(json);

  Map<String, dynamic> toJson() => _$UlogaToJson(this);
}
