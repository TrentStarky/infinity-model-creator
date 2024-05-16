import 'package:infinity_model_creator/models/unit_data/unit_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_container.g.dart';

@JsonSerializable()
class UnitContainer {
  List<UnitData> units;

  UnitContainer({
    required this.units,
});

  factory UnitContainer.fromJson(Map<String, dynamic> json) => _$UnitContainerFromJson(json);

  Map<String, dynamic> toJson() => _$UnitContainerToJson(this);
}