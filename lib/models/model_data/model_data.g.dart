// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelData _$ModelDataFromJson(Map<String, dynamic> json) => ModelData(
      id: json['id'] as int?,
      weapon: json['weapon'] as String?,
      imageAddress: json['imageAddress'] as String?,
      collection: json['collection'] as String?,
      limitedEdition: json['limitedEdition'] as bool?,
    );

Map<String, dynamic> _$ModelDataToJson(ModelData instance) => <String, dynamic>{
      'id': instance.id,
      'weapon': instance.weapon,
      'imageAddress': instance.imageAddress,
      'collection': instance.collection,
      'limitedEdition': instance.limitedEdition,
    };
