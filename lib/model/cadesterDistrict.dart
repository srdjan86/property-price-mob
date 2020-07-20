class CadesterDistrict {
  final String name;
  final int id;
  final String districtName;

  CadesterDistrict({this.id, this.name, this.districtName});

  CadesterDistrict.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
          id: int.parse(json['id']),
          districtName: json['districtName'],
        );
}
