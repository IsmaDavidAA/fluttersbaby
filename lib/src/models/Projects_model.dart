class Project {
  int idProjects;
  String namesPro;
  int idEmployees;

  Project({
    this.idProjects,
    this.namesPro,
    this.idEmployees,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    idProjects: json["idProjects"],
    namesPro: json["namesPro"],
    idEmployees: json["idEmployees"],
  );

  Map<String, dynamic> toJson() => {
    "idProjects": idProjects,
    "namesPro": namesPro,
    "idEmployees": idEmployees,
  };
  String getName(){
    return namesPro;
  }

}
