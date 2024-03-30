// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitContainer _$UnitContainerFromJson(Map<String, dynamic> json) =>
    UnitContainer(
      units: (json['units'] as List<dynamic>)
          .map((e) => UnitData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UnitContainerToJson(UnitContainer instance) =>
    <String, dynamic>{
      'units': instance.units,
    };
