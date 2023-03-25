class CityModel {
  String? capital;
  String? name;

  CityModel(
      {
        this.capital,
        this.name,
       });

  CityModel.fromJson(Map<String, dynamic> json) {
    capital = json['capital'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['capital'] = capital;
    data['name'] = name;
    return data;
  }
}

class Currency {
  String? code;
  String? name;

  Currency({this.code, this.name});

  Currency.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
