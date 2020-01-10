class Date {
  int idDates;
  String dates;
  int idProjects;
  Date({
    this.idDates,
    this.dates,
    this.idProjects,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    idDates: json["idDates"],
    dates: json["dates"],
    idProjects: json["idProjects"],
  );

  Map<String, dynamic> toJson() => {
    "idDates": idDates,
    "dates": dates,
    "idProjects": idProjects,
  };
}