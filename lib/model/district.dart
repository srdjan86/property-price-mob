class District {
  final String name;
  final int id;

  District({this.id, this.name});

  District.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
          id: json['id'],
        );
}
