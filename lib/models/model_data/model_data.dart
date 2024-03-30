import 'package:json_annotation/json_annotation.dart';

part 'model_data.g.dart';

@JsonSerializable()
class ModelData {
  int? id;
  String? weapon;
  String? imageAddress;
  String? collection;
  bool? limitedEdition;

  ModelData({
    this.id,
    this.weapon,
    this.imageAddress,
    this.collection,
    this.limitedEdition,
});

  factory ModelData.fromJson(Map<String, dynamic> json) => _$ModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ModelDataToJson(this);
}