class City {
  City({this.id, this.name});

  int id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'],
        name: json['nome'],
      );

  @override
  String toString() {
    return 'City {id: $id, name: $name}';
  }
}
