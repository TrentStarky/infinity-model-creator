import 'dart:convert';

import 'package:infinity_model_creator/models/model_data/model_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_data.g.dart';

@JsonSerializable()
class UnitData {
  int? id;
  String? name;
  String? unitType;
  String? faction;
  List<ModelData>? models;

  UnitData({
    this.id,
    this.name,
    this.unitType,
    this.faction,
    this.models,
});

  factory UnitData.fromJson(Map<String, dynamic> json) => _$UnitDataFromJson(json);

  Map<String, dynamic> toJson() => _$UnitDataToJson(this);
}