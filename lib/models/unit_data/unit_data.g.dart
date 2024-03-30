// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitData _$UnitDataFromJson(Map<String, dynamic> json) => UnitData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      unitType: json['unitType'] as String?,
      faction: json['faction'] as String?,
      models: (json['models'] as List<dynamic>?)
          ?.map((e) => ModelData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UnitDataToJson(UnitData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unitType': instance.unitType,
      'faction': instance.faction,
      'models': instance.models,
    };
