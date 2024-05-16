enum UnitType {
  lightInfantry(
    displayName: 'Light Infantry',
    databaseName: 'lightInfantry',
  ),
  mediumInfantry(
    displayName: 'Medium Infantry',
    databaseName: 'mediumInfantry',
  ),
  heavyInfantry(
    displayName: 'Heavy Infantry',
    databaseName: 'heavyInfantry',
  ),
  remote(
    displayName: 'Remote',
    databaseName: 'remote',
  ),
  tag(
    displayName: 'TAG',
    databaseName: 'tag',
  ),
  warband(
    displayName: 'Warband',
    databaseName: 'warband',
  ),
  skirmisher(
    displayName: 'Skirmisher',
    databaseName: 'skirmisher',
  ),
  discontinued(
    displayName: 'Discontinued',
    databaseName: 'discontinued',
  ),
  hvt(
    displayName: 'HVT',
    databaseName: 'hvt',
  ),
  civvie(
    displayName: 'Civvies',
    databaseName: 'civvies',
  ),
  equipment(
    displayName: 'Equipment',
    databaseName: 'equipment',
  );

  const UnitType({
    required this.displayName,
    required this.databaseName,
  });

  final String displayName;
  final String databaseName;
}
