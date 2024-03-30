enum Faction {
  panOceania(
    displayName: 'Pan Oceania',
    databaseName: 'panOceania',
  ),
  usAriadna(displayName: 'US Ariadna',
    databaseName: 'usAriadna',),
  aleph(displayName: 'Aleph',
    databaseName: 'aleph',),
  yuJing(displayName: 'Yu Jing',
    databaseName: 'yuJing',),
  combinedArmy(displayName: 'Combined Army',
    databaseName: 'combinedArmy',),
  tohaa(displayName: 'Tohaa',
    databaseName: 'tohaa',),
  jsa(displayName: 'JSA',
    databaseName: 'jsa',),
  nomad(displayName: 'Nomad',
    databaseName: 'nomad',),
  haqqislam(displayName: 'Haqqislam',
    databaseName: 'haqqislam',),
  o12(displayName: 'O-12',
    databaseName: 'o12',),
  mercenary(displayName: 'Mercenary / NA2',
    databaseName: 'mercenary',),
  other(displayName: 'Other',
    databaseName: 'other',);

  const Faction({required this.displayName, required this.databaseName});

  final String displayName;
  final String databaseName;
}
