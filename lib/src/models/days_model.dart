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
  String getDayW(){
    List<String> res = dates.split("-");
    return res[0];
  }
  int getDay(){
    List<String> res = dates.split("-");
    return int.parse(res[1]);
  }
  int getMonth(){
    List<String> res = dates.split("-");
    return int.parse(res[2]);
  }
  int getYear(){
    List<String> res = dates.split("-");
    return int.parse(res[3]);
  }
}

class Est{
  int estado;
  Est({
    this.estado,
  });
  factory Est.fromJson(Map<String, dynamic> json) => Est(
    estado: json["estado"],
  );

  Map<String, dynamic> toJson() => {
    "estado": estado,
  };
}