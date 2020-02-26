
import 'dart:io';
import 'package:fluttersbaby/src/models/Employees_model.dart';
import 'package:fluttersbaby/src/models/Projects_model.dart';
import 'package:fluttersbaby/src/models/days_model.dart';
import 'package:fluttersbaby/src/models/worked_models.dart';
export 'package:fluttersbaby/src/models/Employees_model.dart';
export 'package:fluttersbaby/src/models/Projects_model.dart';
export 'package:fluttersbaby/src/models/days_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();
  Future<Database> get database async{
    if( _database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB()async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'database_App.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async{
        await db.execute(
          'CREATE TABLE Dates('
          ' idDates INTEGER PRIMARY KEY,'
          ' dates DATE,'
          ' idProjects INTEGER'
          ') '
        );
        await db.execute(
          'CREATE TABLE Employees ('
          ' idEmployees INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' sueldosHora INTEGER,'
          ' namesEm TEXT'
          ') '
        );
        await db.execute(
            'CREATE TABLE Projects ('
                ' idProjects INTEGER PRIMARY KEY AUTOINCREMENT,'
                ' namesPro TEXT,'
                ' idEmployees INTEGER'
                ') '
        );
        await db.execute(
            'CREATE TABLE Works ('
                ' idDates INTEGER,'
                ' idProjects INTEGER,'
                ' idEmployees INTEGER,'
                ' hoursWorkEmployees INTEGER'
                ') '
        );
        await db.execute(
            'CREATE TABLE Ests ('
                ' estado INTEGER'
                ') '
        );
      }
    );
  }
  //Crear registros

  nuevoDateRaw( newDate) async{
    final db = await database;
    final res = await db.rawInsert(
      "INSERT Into Dates (idDates, dates, idProjects) "
      "VALUES ( ${ newDate.idDates}, '${ newDate.dates}', ${ newDate.idProjects}"
    );
    return res;
  }

  nuevoProjectRaw(Project newProject) async{
    final db = await database;
    final res = await db.rawInsert(
        "INSERT Into Projects (idProjects, namesPro, idEmployees) "
        "VALUES ( ${ newProject.idProjects}, '${ newProject.namesPro}', ${ newProject.idEmployees}"
    );
    return res;
  }

  nuevoEmployeeRaw(Employee newEmployee) async{
    final db = await database;
    final res = await db.rawInsert(
        "INSERT Into Employees (idEmployees, sueldosHora, namesEm) "
        "VALUES ( ${ newEmployee.idEmployees}, ${ newEmployee.sueldosHora}, '${ newEmployee.namesEm}'"
    );
    return res;
  }

  nuevoDate( var newDate) async{
    final db = await database;
    final res = await db.insert('Dates', newDate.toJson() );
    return res;
  }
  nuevoProject( Project newProject) async{
    final db = await database;
    final res = await db.insert('Projects', newProject.toJson() );
    return res;
  }
  nuevoEmployee( Employee newEmployee) async{
    final db = await database;
    final res = await db.insert('Employees', newEmployee.toJson() );
    return res;
  }
  nuevoWork( WorksModels newWork) async{
    final db = await database;
    final res = await db.insert('Works', newWork.toJson() );
    print("${newWork.idDates}   ${newWork.idProjects}  nuevo");
    return res;
  }

  nuevoEst( Est newEst) async{
    final db = await database;
    final res = await db.insert('Ests', newEst.toJson() );
    return res;
  }
  //SELECT - Obtener informacion
  Future<Date> getDateIdDates( int idDate ) async{
    final db = await database;
    final res = await db.query('Dates', where: 'idDates = ?', whereArgs: [idDate]);
    return res.isNotEmpty ? Date.fromJson(res.first) : null;
  }

  Future<Project> getProjectIdProjects( int idProject ) async{
    final db = await database;
    final res = await db.query('Projects', where: 'idProjects = ?', whereArgs: [idProject]);
    return res.isNotEmpty ? Project.fromJson(res.first) : null;
  }

  Future<Employee> getEmployeeIdEmployees( int idEmployee ) async{
    final db = await database;
    final res = await db.query('Employees', where: 'idEmployees = ?', whereArgs: [idEmployee]);
    return res.isNotEmpty ? Employee.fromJson(res.first) : null;
  }

  //SELECT- ALL

  Future<Est> getEst() async{
    final db = await database;
    final res = await db.query('Ests');
    return res.isNotEmpty ? Est.fromJson(res.first) : null;
  }

  Future<int> deleteAllEst() async{
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Ests');
    return res;
  }


  Future<List<Date>> getAllDates() async{
    final db = await database;
    final res = await db.query('Dates');
    List<Date> list = res.isNotEmpty
                          ? res.map((c) => Date.fromJson(c)).toList()
                          : [];
    return list;
  }
  Future<List<Project>> getAllProjects() async{
    final db = await database;
    final res = await db.query('Projects');
    List<Project> list = res.isNotEmpty
                        ? res.map((c) => Project.fromJson(c)).toList()
                        : [];
    return list;
  }
  Future<List<Employee>> getAllEmployees() async{
    final db = await database;
    final res = await db.query('Employees');
    List<Employee> list = res.isNotEmpty
                          ? res.map((c) => Employee.fromJson(c)).toList()
                          : [];
    return list;
  }
  //actualizar registros

  Future<int> updateDate(Date newDate)async{
    final db = await database;
    final res = await db.update('Dates', newDate.toJson(), where:'idDates = ?', whereArgs: [newDate.idDates] );
    return res;
  }

  Future<int> updateProject(Project newProject)async{
    final db = await database;
    final res = await db.update('Projects', newProject.toJson(), where:'idProjects = ?', whereArgs: [newProject.idProjects] );
    return res;
  }

  Future<int> updateEmployee(Employee newEmployee)async{
    final db = await database;
    final res = await db.update('Employees', newEmployee.toJson(), where:'idEmployees = ?', whereArgs: [newEmployee.idEmployees] );
    return res;
  }
  Future<int> updateEst(Est newEst)async{
    final db = await database;
    final res = await db.update('Ests', newEst.toJson(), where:'est = ?', whereArgs: [newEst.estado] );
    return res;
  }
  Future<int> updateWorkProj(WorksModels newWork)async{
    final db = await database;

    final res = await db.update('Works', newWork.toJson(), where:'idDates = ? AND idProjects = ? ', whereArgs: [newWork.idDates,newWork.idProjects] );
    print(" ${newWork.idDates} ${newWork.idProjects}  $res aniadido");
    return res;
  }
  //Eliminar registros

  Future<int> deleteDate(int idDate) async{
    final db = await database;
    final res = await db.delete('Dates', where: 'idDates = ?', whereArgs: [idDate]);
    return res;
  }
  Future<int> deleteEmployee(int idEmployee) async{
    final db = await database;
    final res = await db.delete('Employees', where: 'idEmployees = ?', whereArgs: [idEmployee]);
    return res;
  }

  Future<int> deleteProject(int idProject) async{
    final db = await database;
    final res = await db.delete('Projects', where: 'idProjects = ?', whereArgs: [idProject]);
    return res;
  }
  Future<int> deleteWorks(int idDate, int idProject) async{
    final db = await database;
    
    final res = await db.rawDelete("DELETE FROM Works WHERE idDates = $idDate AND idProjects = $idProject");
    print("$idDate   $idProject delete $res elements");
    return res;
  }

  Future<int> deleteWorkProj(int idDate, int idProject, int idEmployee) async{
    final db = await database;
    final res = await db.rawDelete("DELETE FROM Works WHERE idDates = $idDate AND idProjects = $idProject AND idEmployees = $idEmployee");
    print("$idDate   $idProject $idEmployee delete $res elements");
    return res;
  }

  Future<int> deleteAllDate() async{
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Dates');
    return res;
  }
  Future<int> deleteAllWork() async{
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Works');
    return res;
  }

  Future<List<WorksModels>> getAllWorksDate(int idDate) async{
    final db = await database;
    final res = await db.query('Works',where: "idDates = ?", whereArgs: [idDate]);
    List<WorksModels> list = res.isNotEmpty
        ? res.map((c) => WorksModels.fromJson(c)).toList()
        : [];
    print(list.length);
    return list;
  }

  Future<List<WorksModels>> getAllWorksDateProj(int idDate, int idProj) async{
    final db = await database;
    final res = await db.query('Works',where: "idDates = ? AND idProjects = ?", whereArgs: [idDate,idProj]);
    List<WorksModels> list = res.isNotEmpty
        ? res.map((c) => WorksModels.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<int> getSueldoTotalEmp(int idEmp) async{
    final db = await database;
    final em = await db.query('Works',where: "idEmployees = ?", whereArgs: [idEmp]);
    int res = 0;
    List<WorksModels> list = em.isNotEmpty
        ? em.map((c) => WorksModels.fromJson(c)).toList()
        : [];
    for(int i = 0; i< list.length;i++){
      res = res + list[i].hoursWorkEmployees;
    }   
    return res;
  }

  Future<WorksModels> exDateProj( int idDate, int idProject ) async{
    final db = await database;
    final res = await db.rawQuery("SELECT idProjects FROM Works WHERE idDates = $idDate AND idProjects = $idProject");
    final r = res.isNotEmpty ? 1 : 0;
    print("$idDate   $idProject su existencia $r");
    return res.isNotEmpty ? WorksModels.fromJson(res.first) : null;
  }

  Future<List<Employee>> totalaPagarPorEmpleado() async{
    final db = await database;
    List<Employee> res = await DBProvider.db.getAllEmployees();
    for(int i=0;i<res.length;i++){
      res[i].sueldosHora = res[i].sueldosHora * await getSueldoTotalEmp(res[i].idEmployees);
    }
    return res;
  }
}

