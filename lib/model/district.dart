class District {
  final String name;
  final String value;

  District({this.name, this.value});

  static List<District> fromJSON(Map<String, String> items) {
    List<District> list = new List<District>();
    items.forEach((f, v) => list.add(District(name: f, value: v)));
    return list;
  }
}
