class Employee {
  int idEmployees;
  String namesEm;

  Employee({
    this.idEmployees,
    this.namesEm,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    idEmployees: json["idEmployees"],
    namesEm: json["nameEm"],
  );

  Map<String, dynamic> toJson() => {
    "idEmployees": idEmployees,
    "namesEm": namesEm,
  };
}
