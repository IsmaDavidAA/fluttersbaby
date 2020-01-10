import 'dart:io';
import 'package:fluttersbaby/src/models/Employees_model.dart';
import 'package:fluttersbaby/src/models/Projects_model.dart';
import 'package:fluttersbaby/src/models/days_model.dart';
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
          ' idProjects INTEGER FOREIGN KEY'
          ') '
          'CREATE TABLE Projects('
          ' idProyect INTEGER PRIMARY KEY,'
          ' namesPro TEXT,'
          ' idEmployees INTEGER FOREIGN KEY'
          ') '
          'CREATE TABLE Employees('
          ' idEmployees INTEGER PRIMARY KEY,'
          ' namesEm TEXT'
          ')'
        );
      }
    );
  }
  //Crear registros
  nuevoDateRaw(Date newDate) async{
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
        "INSERT Into Employees (idEmployees, namesEm) "
        "VALUES ( ${ newEmployee.idEmployees}, '${ newEmployee.namesEm}'"
    );
    return res;
  }

  nuevoDate( Date newDate) async{
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

  Future<List<Date>> getAllDates() async{
    final db = await database;
    final res = await db.query('Dates');
    List<Date> list = res.isNotEmpty
                          ? res.map((c) => Date.fromJson(c)).toList()
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

  //Eliminar registros

  Future<int> deleteDate(int idDate) async{
    final db = await database;
    final res = await db.delete('Dates', where: 'idDates = ?', whereArgs: [idDate]);
    return res;
  }

  Future<int> deleteAllDate() async{
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Dates');
    return res;
  }
}