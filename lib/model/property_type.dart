class PropertyType {
  final String name;
  final int id;

  PropertyType({this.name, this.id});

  PropertyType.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
        );

  static List<PropertyType> fromList(List<dynamic> listJson) {
    List<PropertyType> list = List<PropertyType>();
    listJson.forEach((json) {
      list.add(PropertyType.fromJson(json));
    });
    return list;
  }
}

class PropertyCategory {
  final String name;
  final int id;
  final List<PropertyType> types;

  PropertyCategory({this.name, this.types, this.id});

  PropertyCategory.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
          types: PropertyType.fromList(json['types']),
          id: json['id'],
        );
}
