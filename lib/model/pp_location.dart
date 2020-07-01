class PPLocation {
  final double lat;
  final double lon;

  PPLocation({this.lat, this.lon});

  PPLocation.fromJSON(Map<String, dynamic> json)
      : this(
          lat: json['lat'],
          lon: json['lon'],
        );
}
