class CountriesModel {
  Name? name;
  String? cca2;
  String? ccn3;
  String? cca3;
  String? cioc;
  bool? independent;
  String? status;
  bool? unMember;
  String? region;
  String? subregion;
  bool? landlocked;
  String? flag;
  String? fifa;

  CountriesModel({
    this.name,
    this.cca2,
    this.ccn3,
    this.cca3,
    this.cioc,
    this.independent,
    this.status,
    this.unMember,
    this.region,
    this.subregion,
    this.landlocked,
    this.flag,
    this.fifa,
  });

  CountriesModel.fromJson(List<dynamic> json) {
    for (var element in json) {
      name = element['name'] != null ? Name.fromJson(element['name']) : null;
      cca2 = element['cca2'];
      ccn3 = element['ccn3'];
      cca3 = element['cca3'];
      cioc = element['cioc'];
      independent = element['independent'];
      status = element['status'];

      unMember = element['unMember'];
      region = element['region'];
      subregion = element['subregion'];
      landlocked = element['landlocked'];
      flag = element['flag'];
      fifa = element['fifa'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['cca2'] = cca2;
    data['ccn3'] = ccn3;
    data['cca3'] = cca3;
    data['cioc'] = cioc;
    data['independent'] = independent;
    data['status'] = status;
    data['unMember'] = unMember;
    data['region'] = region;
    data['subregion'] = subregion;
    data['fifa'] = fifa;
    return data;
  }
}

class Name {
  String? common;
  String? official;

  Name({this.common, this.official});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
    official = json['official'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['common'] = common;
    data['official'] = official;
    return data;
  }
}
