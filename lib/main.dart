import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinity_model_creator/faction.dart';
import 'package:infinity_model_creator/models/model_data/model_data.dart';
import 'package:infinity_model_creator/models/unit_container/unit_container.dart';
import 'package:infinity_model_creator/models/unit_data/unit_data.dart';
import 'package:infinity_model_creator/unit_type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinity Model JSON-erfier',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UnitContainer unitContainer = UnitContainer(units: []);
  final _modelNameController = TextEditingController();
  Faction? selectedFaction;
  UnitType? selectedUnitType;
  List<ModelData> models = [];
  int lastUnitId = 1;
  int lastModelId = 1;

  @override
  void initState() {
    _modelNameController.addListener(() {
      setState(() {});
    });
    final file = File.fromUri(Uri.file(
        r'C:\Users\MrT_6\IdeaProjects\infinity_model_creator\lib\all_units.json'));
    final jsonString = file.readAsStringSync();
    unitContainer = UnitContainer.fromJson(jsonDecode(jsonString));
    lastUnitId = unitContainer.units.fold(
        1,
        (previousValue, element) =>
            previousValue! < element.id! ? element.id : previousValue)!;
    lastModelId = unitContainer.units.fold(
        1,
        (previousValue, element) => previousValue! <
                element.models!.fold(
                    1,
                    (previousValue, element) => previousValue < element.id!
                        ? element.id!
                        : previousValue)
            ? element.models!.last.id
            : previousValue)!;
    print(lastUnitId);
    print(lastModelId);

    super.initState();
  }

  void _finish() {
    final matches = unitContainer.units
        .where((element) => element.name == _modelNameController.text);
    if (matches.isNotEmpty) {
      matches.first.models = models;
    } else {
      lastUnitId++;
      unitContainer.units.add(UnitData(
        id: lastUnitId,
        name: _modelNameController.text,
        faction: selectedFaction?.databaseName,
        unitType: selectedUnitType?.databaseName,
        models: models,
      ));
    }

    _writeToFile();

    _clearAll(false);
  }

  void _clearAll(bool deleteFaction) {
    setState(() {
      _modelNameController.text = '';
      selectedUnitType = null;
      if (deleteFaction) {
        selectedFaction = null;
      }
      models = [];
    });
  }

  void _addNewModel() {
    lastModelId++;
    setState(() {
      models.add(ModelData(id: lastModelId));
    });
  }

  void _removeModel(ModelData data) {
    setState(() {
      models.remove(data);
    });
  }

  _writeToFile() {
    final file = File.fromUri(Uri.file(
        r'C:\Users\MrT_6\IdeaProjects\infinity_model_creator\lib\all_units.json'));
    file.deleteSync();
    file.createSync();
    file.writeAsStringSync(jsonEncode(unitContainer.toJson()));
  }

  void _loadData(UnitData data) {
    setState(() {
      _modelNameController.text = data.name!;
      selectedFaction = Faction.values.byName(data.faction!);
      selectedUnitType = UnitType.values.byName(data.unitType!);
      models = data.models!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                for (UnitData data in unitContainer.units.where((element) =>
                    element.name?.contains(_modelNameController.text) ?? false))
                  GestureDetector(
                    onTap: () => _loadData(data),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        data.name!,
                        maxLines: 6,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          VerticalDivider(),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: _modelNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('UNIT NAME'),
                    ),
                  ),
                  SizedBox(height: 32),
                  DropdownButton<UnitType>(
                    hint: Text('Unit type'),
                    value: selectedUnitType,
                    items: [
                      for (UnitType type in UnitType.values)
                        DropdownMenuItem(
                          child: Text(type.displayName),
                          value: type,
                        ),
                    ],
                    onChanged: (type) => setState(() {
                      selectedUnitType = type;
                    }),
                  ),
                  SizedBox(height: 32),
                  DropdownButton<Faction>(
                    hint: Text('Faction'),
                    value: selectedFaction,
                    items: [
                      for (Faction faction in Faction.values)
                        DropdownMenuItem(
                          child: Text(faction.displayName),
                          value: faction,
                        ),
                    ],
                    onChanged: (faction) => setState(() {
                      selectedFaction = faction;
                    }),
                  ),
                  SizedBox(height: 32),
                  for (ModelData model in models)
                    Model(
                      modelData: model,
                      url: 'https://storage.cloud.google.com/infinity-miniature-images/${selectedFaction?.displayName}/${_modelNameController.text}',
                      onDelete: _removeModel,
                    ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                        onPressed: _addNewModel, child: Text('ADD NEW MODEL')),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(onPressed: _finish, child: Text('FINISH')),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                        onPressed: () => _clearAll(true), child: Text('Clear')),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Model extends StatefulWidget {
  const Model({
    super.key,
    required this.modelData,
    required this.onDelete,
    required this.url,
  });

  final ModelData modelData;
  final Function(ModelData) onDelete;
  final String url;

  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  final TextEditingController _weaponController = TextEditingController();
  final TextEditingController _imageAddressController = TextEditingController();

  @override
  void initState() {
    _weaponController.text = widget.modelData.weapon ?? '';
    _imageAddressController.text = widget.modelData.imageAddress ?? widget.url;
    _weaponController.addListener(_weaponListener);
    _imageAddressController.addListener(_imageAddressListener);
    super.initState();
  }

  void _weaponListener() {
    widget.modelData.weapon = _weaponController.text;
  }

  void _imageAddressListener() {
    widget.modelData.imageAddress = _imageAddressController.text;
  }

  void _toggleCodeOneCheck(bool? val) {
    setState(() {
      if (val == true) {
        widget.modelData.collection = 'codeOne';
      } else {
        widget.modelData.collection = null;
      }
    });
  }

  void _toggleLimitedEditionCheck(bool? val) {
    setState(() {
      if (val == true) {
        widget.modelData.limitedEdition = true;
      } else {
        widget.modelData.limitedEdition = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _weaponController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Weapon'),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _imageAddressController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Image Address'),
            ),
          ),
          Row(
            children: [
              Checkbox(
                  value: widget.modelData.collection == 'codeOne',
                  onChanged: _toggleCodeOneCheck),
              Text('CodeOne'),
              SizedBox(width: 16),
              Checkbox(
                  value: widget.modelData.limitedEdition == true,
                  onChanged: _toggleLimitedEditionCheck),
              Text('Limited Edition'),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => widget.onDelete(widget.modelData),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
