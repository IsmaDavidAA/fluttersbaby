class Employee {
  int idEmployees;
  int sueldosHora;
  String namesEm;

  Employee({
    this.idEmployees,
    this.sueldosHora,
    this.namesEm,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    idEmployees: json["idEmployees"],
    sueldosHora: json["sueldosHora"],
    namesEm: json["namesEm"],
  );

  Map<String, dynamic> toJson() => {
    "idEmployees": idEmployees,
    "sueldosHora": sueldosHora,
    "namesEm": namesEm,
  };
}
