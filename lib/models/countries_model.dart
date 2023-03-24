class CountriesModel {
  Name? name;
  List<String>? tld;
  String? cca2;
  String? ccn3;
  String? cca3;
  String? cioc;
  bool? independent;
  String? status;
  bool? unMember;
  Currencies? currencies;
  Idd? idd;
  List<String>? capital;
  List<String>? altSpellings;
  String? region;
  String? subregion;
  Languages? languages;
  Translations? translations;
  List<double>? latlng;
  bool? landlocked;
  List<String>? borders;
  int? area;
  Demonyms? demonyms;
  String? flag;
  Maps? maps;
  int? population;
  String? fifa;
  Car? car;
  List<String>? timezones;
  List<String>? continents;
  Flags? flags;
  CoatOfArms? coatOfArms;
  String? startOfWeek;
  CapitalInfo? capitalInfo;
  PostalCode? postalCode;

  CountriesModel(
      {this.name,
      this.tld,
      this.cca2,
      this.ccn3,
      this.cca3,
      this.cioc,
      this.independent,
      this.status,
      this.unMember,
      this.currencies,
      this.idd,
      this.capital,
      this.altSpellings,
      this.region,
      this.subregion,
      this.languages,
      this.translations,
      this.latlng,
      this.landlocked,
      this.borders,
      this.area,
      this.demonyms,
      this.flag,
      this.maps,
      this.population,
      this.fifa,
      this.car,
      this.timezones,
      this.continents,
      this.flags,
      this.coatOfArms,
      this.startOfWeek,
      this.capitalInfo,
      this.postalCode});

  CountriesModel.fromJson(List<dynamic> json) {
    for (var element in json) {
      name = element["name"] == null ? null : Name.fromJson(element["name"]);
      tld = element["tld"] == null ? null : List<String>.from(element["tld"]);
      cca2 = element["cca2"];
      ccn3 = element["ccn3"];
      cca3 = element["cca3"];
      cioc = element["cioc"];
      independent = element["independent"];
      status = element["status"];
      unMember = element["unMember"];
      currencies = element["currencies"] == null
          ? null
          : Currencies.fromJson(element["currencies"]);
      idd = element["idd"] == null ? null : Idd.fromJson(element["idd"]);
      capital = element["capital"] == null
          ? null
          : List<String>.from(element["capital"]);
      altSpellings = element["altSpellings"] == null
          ? null
          : List<String>.from(element["altSpellings"]);
      region = element["region"];
      subregion = element["subregion"];
      languages = element["languages"] == null
          ? null
          : Languages.fromJson(element["languages"]);
      translations = element["translations"] == null
          ? null
          : Translations.fromJson(element["translations"]);
      latlng = element["latlng"] == null
          ? null
          : List<double>.from(element["latlng"]);
      landlocked = element["landlocked"];
      borders = element["borders"] == null
          ? null
          : List<String>.from(element["borders"]);
      area = (element["area"] as num).toInt();
      demonyms = element["demonyms"] == null
          ? null
          : Demonyms.fromJson(element["demonyms"]);
      flag = element["flag"];
      maps = element["maps"] == null ? null : Maps.fromJson(element["maps"]);
      population = (element["population"] as num).toInt();
      fifa = element["fifa"];
      car = element["car"] == null ? null : Car.fromJson(element["car"]);
      timezones = element["timezones"] == null
          ? null
          : List<String>.from(element["timezones"]);
      continents = element["continents"] == null
          ? null
          : List<String>.from(element["continents"]);
      flags =
          element["flags"] == null ? null : Flags.fromJson(element["flags"]);
      coatOfArms = element["coatOfArms"] == null
          ? null
          : CoatOfArms.fromJson(element["coatOfArms"]);
      startOfWeek = element["startOfWeek"];
      capitalInfo = element["capitalInfo"] == null
          ? null
          : CapitalInfo.fromJson(element["capitalInfo"]);
      postalCode = element["postalCode"] == null
          ? null
          : PostalCode.fromJson(element["postalCode"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data["name"] = name?.toJson();
    }
    if (tld != null) {
      data["tld"] = tld;
    }
    data["cca2"] = cca2;
    data["ccn3"] = ccn3;
    data["cca3"] = cca3;
    data["cioc"] = cioc;
    data["independent"] = independent;
    data["status"] = status;
    data["unMember"] = unMember;
    if (currencies != null) {
      data["currencies"] = currencies?.toJson();
    }
    if (idd != null) {
      data["idd"] = idd?.toJson();
    }
    if (capital != null) {
      data["capital"] = capital;
    }
    if (altSpellings != null) {
      data["altSpellings"] = altSpellings;
    }
    data["region"] = region;
    data["subregion"] = subregion;
    if (languages != null) {
      data["languages"] = languages?.toJson();
    }
    if (translations != null) {
      data["translations"] = translations?.toJson();
    }
    if (latlng != null) {
      data["latlng"] = latlng;
    }
    data["landlocked"] = landlocked;
    if (borders != null) {
      data["borders"] = borders;
    }
    data["area"] = area;
    if (demonyms != null) {
      data["demonyms"] = demonyms?.toJson();
    }
    data["flag"] = flag;
    if (maps != null) {
      data["maps"] = maps?.toJson();
    }
    data["population"] = population;
    data["fifa"] = fifa;
    if (car != null) {
      data["car"] = car?.toJson();
    }
    if (timezones != null) {
      data["timezones"] = timezones;
    }
    if (continents != null) {
      data["continents"] = continents;
    }
    if (flags != null) {
      data["flags"] = flags?.toJson();
    }
    if (coatOfArms != null) {
      data["coatOfArms"] = coatOfArms?.toJson();
    }
    data["startOfWeek"] = startOfWeek;
    if (capitalInfo != null) {
      data["capitalInfo"] = capitalInfo?.toJson();
    }
    if (postalCode != null) {
      data["postalCode"] = postalCode?.toJson();
    }
    return data;
  }
}

class PostalCode {
  String? format;
  String? regex;

  PostalCode({this.format, this.regex});

  PostalCode.fromJson(List<dynamic> json) {
    for (var element in json) {
      format = element["format"];
      regex = element["regex"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["format"] = format;
    data["regex"] = regex;
    return data;
  }
}

class CapitalInfo {
  List<double>? latlng;

  CapitalInfo({this.latlng});

  CapitalInfo.fromJson(List<dynamic> json) {
    for (var element in json) {
      latlng = element["latlng"] == null
          ? null
          : List<double>.from(element["latlng"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (latlng != null) {
      data["latlng"] = latlng;
    }
    return data;
  }
}

class CoatOfArms {
  String? png;
  String? svg;

  CoatOfArms({this.png, this.svg});

  CoatOfArms.fromJson(List<dynamic> json) {
    for (var element in json) {
      png = element["png"];
      svg = element["svg"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["png"] = png;
    data["svg"] = svg;
    return data;
  }
}

class Flags {
  String? png;
  String? svg;
  String? alt;

  Flags({this.png, this.svg, this.alt});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json["png"];
    svg = json["svg"];
    alt = json["alt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["png"] = png;
    data["svg"] = svg;
    data["alt"] = alt;
    return data;
  }
}

class Car {
  List<String>? signs;
  String? side;

  Car({this.signs, this.side});

  Car.fromJson(Map<String, dynamic> json) {
    signs = json["signs"] == null ? null : List<String>.from(json["signs"]);
    side = json["side"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (signs != null) {
      data["signs"] = signs;
    }
    data["side"] = side;
    return data;
  }
}

class Maps {
  String? googleMaps;
  String? openStreetMaps;

  Maps({this.googleMaps, this.openStreetMaps});

  Maps.fromJson(Map<String, dynamic> json) {
    googleMaps = json["googleMaps"];
    openStreetMaps = json["openStreetMaps"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["googleMaps"] = googleMaps;
    data["openStreetMaps"] = openStreetMaps;
    return data;
  }
}

class Demonyms {
  Eng? eng;
  Fra1? fra;

  Demonyms({this.eng, this.fra});

  Demonyms.fromJson(Map<String, dynamic> json) {
    eng = json["eng"] == null ? null : Eng.fromJson(json["eng"]);
    fra = json["fra"] == null ? null : Fra1.fromJson(json["fra"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eng != null) {
      data["eng"] = eng?.toJson();
    }
    if (fra != null) {
      data["fra"] = fra?.toJson();
    }
    return data;
  }
}

class Fra1 {
  String? f;
  String? m;

  Fra1({this.f, this.m});

  Fra1.fromJson(Map<String, dynamic> json) {
    f = json["f"];
    m = json["m"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["f"] = f;
    data["m"] = m;
    return data;
  }
}

class Eng {
  String? f;
  String? m;

  Eng({this.f, this.m});

  Eng.fromJson(Map<String, dynamic> json) {
    f = json["f"];
    m = json["m"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["f"] = f;
    data["m"] = m;
    return data;
  }
}

class Translations {
  Ara? ara;
  Bre? bre;
  Ces? ces;
  Cym? cym;
  Deu? deu;
  Est? est;
  Fin? fin;
  Fra? fra;
  Hrv? hrv;
  Hun? hun;
  Ita? ita;
  Jpn? jpn;
  Kor? kor;
  Nld? nld;
  Per? per;
  Pol? pol;
  Por? por;
  Rus? rus;
  Slk? slk;
  Spa1? spa;
  Srp? srp;
  Swe? swe;
  Tur? tur;
  Urd? urd;
  Zho? zho;

  Translations(
      {this.ara,
      this.bre,
      this.ces,
      this.cym,
      this.deu,
      this.est,
      this.fin,
      this.fra,
      this.hrv,
      this.hun,
      this.ita,
      this.jpn,
      this.kor,
      this.nld,
      this.per,
      this.pol,
      this.por,
      this.rus,
      this.slk,
      this.spa,
      this.srp,
      this.swe,
      this.tur,
      this.urd,
      this.zho});

  Translations.fromJson(Map<String, dynamic> json) {
    ara = json["ara"] == null ? null : Ara.fromJson(json["ara"]);
    bre = json["bre"] == null ? null : Bre.fromJson(json["bre"]);
    ces = json["ces"] == null ? null : Ces.fromJson(json["ces"]);
    cym = json["cym"] == null ? null : Cym.fromJson(json["cym"]);
    deu = json["deu"] == null ? null : Deu.fromJson(json["deu"]);
    est = json["est"] == null ? null : Est.fromJson(json["est"]);
    fin = json["fin"] == null ? null : Fin.fromJson(json["fin"]);
    fra = json["fra"] == null ? null : Fra.fromJson(json["fra"]);
    hrv = json["hrv"] == null ? null : Hrv.fromJson(json["hrv"]);
    hun = json["hun"] == null ? null : Hun.fromJson(json["hun"]);
    ita = json["ita"] == null ? null : Ita.fromJson(json["ita"]);
    jpn = json["jpn"] == null ? null : Jpn.fromJson(json["jpn"]);
    kor = json["kor"] == null ? null : Kor.fromJson(json["kor"]);
    nld = json["nld"] == null ? null : Nld.fromJson(json["nld"]);
    per = json["per"] == null ? null : Per.fromJson(json["per"]);
    pol = json["pol"] == null ? null : Pol.fromJson(json["pol"]);
    por = json["por"] == null ? null : Por.fromJson(json["por"]);
    rus = json["rus"] == null ? null : Rus.fromJson(json["rus"]);
    slk = json["slk"] == null ? null : Slk.fromJson(json["slk"]);
    spa = json["spa"] == null ? null : Spa1.fromJson(json["spa"]);
    srp = json["srp"] == null ? null : Srp.fromJson(json["srp"]);
    swe = json["swe"] == null ? null : Swe.fromJson(json["swe"]);
    tur = json["tur"] == null ? null : Tur.fromJson(json["tur"]);
    urd = json["urd"] == null ? null : Urd.fromJson(json["urd"]);
    zho = json["zho"] == null ? null : Zho.fromJson(json["zho"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ara != null) {
      data["ara"] = ara?.toJson();
    }
    if (bre != null) {
      data["bre"] = bre?.toJson();
    }
    if (ces != null) {
      data["ces"] = ces?.toJson();
    }
    if (cym != null) {
      data["cym"] = cym?.toJson();
    }
    if (deu != null) {
      data["deu"] = deu?.toJson();
    }
    if (est != null) {
      data["est"] = est?.toJson();
    }
    if (fin != null) {
      data["fin"] = fin?.toJson();
    }
    if (fra != null) {
      data["fra"] = fra?.toJson();
    }
    if (hrv != null) {
      data["hrv"] = hrv?.toJson();
    }
    if (hun != null) {
      data["hun"] = hun?.toJson();
    }
    if (ita != null) {
      data["ita"] = ita?.toJson();
    }
    if (jpn != null) {
      data["jpn"] = jpn?.toJson();
    }
    if (kor != null) {
      data["kor"] = kor?.toJson();
    }
    if (nld != null) {
      data["nld"] = nld?.toJson();
    }
    if (per != null) {
      data["per"] = per?.toJson();
    }
    if (pol != null) {
      data["pol"] = pol?.toJson();
    }
    if (por != null) {
      data["por"] = por?.toJson();
    }
    if (rus != null) {
      data["rus"] = rus?.toJson();
    }
    if (slk != null) {
      data["slk"] = slk?.toJson();
    }
    if (spa != null) {
      data["spa"] = spa?.toJson();
    }
    if (srp != null) {
      data["srp"] = srp?.toJson();
    }
    if (swe != null) {
      data["swe"] = swe?.toJson();
    }
    if (tur != null) {
      data["tur"] = tur?.toJson();
    }
    if (urd != null) {
      data["urd"] = urd?.toJson();
    }
    if (zho != null) {
      data["zho"] = zho?.toJson();
    }
    return data;
  }
}

class Zho {
  String? official;
  String? common;

  Zho({this.official, this.common});

  Zho.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Urd {
  String? official;
  String? common;

  Urd({this.official, this.common});

  Urd.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Tur {
  String? official;
  String? common;

  Tur({this.official, this.common});

  Tur.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Swe {
  String? official;
  String? common;

  Swe({this.official, this.common});

  Swe.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Srp {
  String? official;
  String? common;

  Srp({this.official, this.common});

  Srp.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Spa1 {
  String? official;
  String? common;

  Spa1({this.official, this.common});

  Spa1.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Slk {
  String? official;
  String? common;

  Slk({this.official, this.common});

  Slk.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Rus {
  String? official;
  String? common;

  Rus({this.official, this.common});

  Rus.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Por {
  String? official;
  String? common;

  Por({this.official, this.common});

  Por.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Pol {
  String? official;
  String? common;

  Pol({this.official, this.common});

  Pol.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Per {
  String? official;
  String? common;

  Per({this.official, this.common});

  Per.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Nld {
  String? official;
  String? common;

  Nld({this.official, this.common});

  Nld.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Kor {
  String? official;
  String? common;

  Kor({this.official, this.common});

  Kor.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Jpn {
  String? official;
  String? common;

  Jpn({this.official, this.common});

  Jpn.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Ita {
  String? official;
  String? common;

  Ita({this.official, this.common});

  Ita.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Hun {
  String? official;
  String? common;

  Hun({this.official, this.common});

  Hun.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Hrv {
  String? official;
  String? common;

  Hrv({this.official, this.common});

  Hrv.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Fra {
  String? official;
  String? common;

  Fra({this.official, this.common});

  Fra.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Fin {
  String? official;
  String? common;

  Fin({this.official, this.common});

  Fin.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Est {
  String? official;
  String? common;

  Est({this.official, this.common});

  Est.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Deu {
  String? official;
  String? common;

  Deu({this.official, this.common});

  Deu.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Cym {
  String? official;
  String? common;

  Cym({this.official, this.common});

  Cym.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Ces {
  String? official;
  String? common;

  Ces({this.official, this.common});

  Ces.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Bre {
  String? official;
  String? common;

  Bre({this.official, this.common});

  Bre.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Ara {
  String? official;
  String? common;

  Ara({this.official, this.common});

  Ara.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}

class Languages {
  String? spa;

  Languages({this.spa});

  Languages.fromJson(Map<String, dynamic> json) {
    spa = json["spa"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["spa"] = spa;
    return data;
  }
}

class Idd {
  String? root;
  List<String>? suffixes;

  Idd({this.root, this.suffixes});

  Idd.fromJson(Map<String, dynamic> json) {
    root = json["root"];
    suffixes =
        json["suffixes"] == null ? null : List<String>.from(json["suffixes"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["root"] = root;
    if (suffixes != null) {
      data["suffixes"] = suffixes;
    }
    return data;
  }
}

class Currencies {
  Gtq? gtq;

  Currencies({this.gtq});

  Currencies.fromJson(Map<String, dynamic> json) {
    gtq = json["GTQ"] == null ? null : Gtq.fromJson(json["GTQ"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gtq != null) {
      data["GTQ"] = gtq?.toJson();
    }
    return data;
  }
}

class Gtq {
  String? name;
  String? symbol;

  Gtq({this.name, this.symbol});

  Gtq.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    symbol = json["symbol"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["symbol"] = symbol;
    return data;
  }
}

class Name {
  String? common;
  String? official;
  NativeName? nativeName;

  Name({this.common, this.official, this.nativeName});

  Name.fromJson(List<dynamic> json) {
    for (var element in json) {
      common = element["common"];
      official = element["official"];
      nativeName = element["nativeName"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["common"] = common;
    data["official"] = official;
    if (nativeName != null) {
      data["nativeName"] = nativeName?.toJson();
    }
    return data;
  }
}

class NativeName {
  Spa? spa;

  NativeName({this.spa});

  NativeName.fromJson(Map<String, dynamic> json) {
    spa = json["spa"] == null ? null : Spa.fromJson(json["spa"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (spa != null) {
      data["spa"] = spa?.toJson();
    }
    return data;
  }
}

class Spa {
  String? official;
  String? common;

  Spa({this.official, this.common});

  Spa.fromJson(Map<String, dynamic> json) {
    official = json["official"];
    common = json["common"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["official"] = official;
    data["common"] = common;
    return data;
  }
}
