class SignsApi {
  final String sign;
  final DateTime date;
  final String horoscope;

  SignsApi({required this.sign, required this.date, required this.horoscope});

  factory SignsApi.fromJson(Map<String, dynamic> json) {
    return SignsApi(
      sign: json['name'],
      date: DateTime.parse(json["date"]),
      horoscope: json['horoscope'],
    );
  }
  Map<String, dynamic> toJson() => {
        "sign": sign,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "horoscope": horoscope,
      };
}
