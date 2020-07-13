class PropertyType {
  final String name;
  final int id;

  PropertyType({this.name, this.id});

  PropertyType.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
        );
}
