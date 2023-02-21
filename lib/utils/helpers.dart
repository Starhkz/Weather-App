String cityNameFromJSON(json) => json['city'] ?? 'No Name';

List<int> toIntList(List<String> list) {
  return list.map((val) => int.parse(val)).toList();
}

List<String> toStringList(List<int> value) {
  return value.map((val) => val.toString()).toList();
}

String imageUrl(String icon) {
  String endpoint = 'http://openweathermap.org/img/wn/$icon@4x.png';
  return endpoint;
}
