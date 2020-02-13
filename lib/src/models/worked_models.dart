
class WorksModels {
  int idDates;
  int idProjects;
  int idEmployees;
  int hoursWorkEmployees;

  WorksModels({
    this.idDates,
    this.idProjects,
    this.idEmployees,
    this.hoursWorkEmployees,
  });

  factory WorksModels.fromJson(Map<String, dynamic> json) => WorksModels(
    idDates: json["idDates"],
    idProjects: json["idProjects"],
    idEmployees: json["idEmployees"],
    hoursWorkEmployees: json["hoursWorkEmployees"],
  );

  Map<String, dynamic> toJson() => {
    "idDates": idDates,
    "idProjects": idProjects,
    "idEmployees": idEmployees,
    "hoursWorkEmployees": hoursWorkEmployees,
  };
  bool isEqP(int idDate, int idProject){
    return (this.idDates == idDate && this.idProjects == idProject);
  }
  bool isEqProEmp(int idDate, int idProject, int idEmplo){
    return (this.idDates == idDate && this.idProjects == idProject && this.idEmployees == idEmplo);
  }
}
