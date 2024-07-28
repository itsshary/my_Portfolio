class BookModel {
  String? userId;
  String date;
  String time;
  String? service;

  BookModel({
    required this.userId,
    required this.date,
    required this.time,
    required this.service,
  });

  factory BookModel.fromjson(Map<String, dynamic> json) => BookModel(
        userId: json["userId"],
        date: json["date"],
        time: json["time"],
        service: json["service"],
      );
  Map<String, dynamic> tojson() =>
      {"date": date, "userId": userId, "time": time, "service": service};
}
