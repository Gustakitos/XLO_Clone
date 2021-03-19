class UF {
  UF({
    this.id,
    this.name,
    this.initials,
  });

  factory UF.fromJson(Map<String, dynamic> json) => UF(
        id: json['id'],
        initials: json['sigla'],
        name: json['nome'],
      );

  int id;
  String name;
  String initials;

  @override
  String toString() {
    return 'UF{id: $id, initials: $initials, name: $name}';
  }
}
