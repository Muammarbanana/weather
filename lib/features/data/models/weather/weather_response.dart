import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse extends Equatable {
  @JsonKey(name: "cod")
  final String? cod;
  @JsonKey(name: "message")
  final int? message;
  @JsonKey(name: "cnt")
  final int? cnt;
  @JsonKey(name: "list")
  final List<ListElement>? list;
  @JsonKey(name: "city")
  final City? city;

  const WeatherResponse({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);

  @override
  List<Object?> get props => [cod, message, cnt, list, city];

  @override
  bool get stringify => true;
}

@JsonSerializable()
class City extends Equatable {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "coord")
  final Coord? coord;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "population")
  final int? population;
  @JsonKey(name: "timezone")
  final int? timezone;
  @JsonKey(name: "sunrise")
  final int? sunrise;
  @JsonKey(name: "sunset")
  final int? sunset;

  const City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  @override
  List<Object?> get props =>
      [id, name, coord, country, population, timezone, sunrise, sunset];

  @override
  bool get stringify => true;
}

@JsonSerializable()
class Coord extends Equatable {
  @JsonKey(name: "lat")
  final double? lat;
  @JsonKey(name: "lon")
  final double? lon;

  const Coord({
    this.lat,
    this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);

  @override
  List<Object?> get props => [lat, lon];

  @override
  bool get stringify => true;
}

@JsonSerializable()
class ListElement extends Equatable {
  @JsonKey(name: "dt")
  final int? dt;
  @JsonKey(name: "main")
  final Main? main;
  @JsonKey(name: "weather")
  final List<Weather>? weather;
  @JsonKey(name: "clouds")
  final Clouds? clouds;
  @JsonKey(name: "wind")
  final Wind? wind;
  @JsonKey(name: "visibility")
  final int? visibility;
  @JsonKey(name: "pop")
  final double? pop;
  @JsonKey(name: "rain")
  final Rain? rain;
  @JsonKey(name: "sys")
  final Sys? sys;
  @JsonKey(name: "dt_txt")
  final DateTime? dtTxt;

  const ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) =>
      _$ListElementFromJson(json);

  Map<String, dynamic> toJson() => _$ListElementToJson(this);

  @override
  List<Object?> get props =>
      [dt, main, weather, clouds, wind, visibility, pop, rain, sys, dtTxt];

  @override
  bool? get stringify => true;
}

@JsonSerializable()
class Clouds extends Equatable {
  @JsonKey(name: "all")
  final int? all;

  const Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);

  @override
  List<Object?> get props => [all];

  @override
  bool? get stringify => true;
}

@JsonSerializable()
class Main extends Equatable {
  @JsonKey(name: "temp")
  final double? temp;
  @JsonKey(name: "feels_like")
  final double? feelsLike;
  @JsonKey(name: "temp_min")
  final double? tempMin;
  @JsonKey(name: "temp_max")
  final double? tempMax;
  @JsonKey(name: "pressure")
  final int? pressure;
  @JsonKey(name: "sea_level")
  final int? seaLevel;
  @JsonKey(name: "grnd_level")
  final int? grndLevel;
  @JsonKey(name: "humidity")
  final int? humidity;
  @JsonKey(name: "temp_kf")
  final double? tempKf;

  const Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        seaLevel,
        grndLevel,
        humidity,
        tempKf
      ];

  @override
  bool? get stringify => true;
}

@JsonSerializable()
class Rain extends Equatable {
  @JsonKey(name: "3h")
  final double? the3H;

  const Rain({
    this.the3H,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);

  Map<String, dynamic> toJson() => _$RainToJson(this);

  @override
  List<Object?> get props => [the3H];

  @override
  bool? get stringify => true;
}

@JsonSerializable()
class Sys extends Equatable {
  @JsonKey(name: "pod")
  final String? pod;

  const Sys({
    this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);

  @override
  List<Object?> get props => [pod];

  @override
  bool? get stringify => true;
}

@JsonSerializable()
class Weather extends Equatable {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "main")
  final String? main;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "icon")
  final String? icon;

  const Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object?> get props => [id, main, description, icon];

  @override
  bool? get stringify => true;
}

@JsonSerializable()
class Wind extends Equatable {
  @JsonKey(name: "speed")
  final double? speed;
  @JsonKey(name: "deg")
  final int? deg;
  @JsonKey(name: "gust")
  final double? gust;

  const Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);

  @override
  List<Object?> get props => [speed, deg, gust];

  @override
  bool? get stringify => true;
}
