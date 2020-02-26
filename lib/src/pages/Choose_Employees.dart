



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersbaby/src/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:fluttersbaby/src/models/worked_models.dart';
import 'package:fluttersbaby/src/pages/Choose_Project.dart';
import 'package:fluttersbaby/src/providers/db_provider.dart';

class MyCEmp extends StatelessWidget with NavigationStates{
  var date;
  var proj;
  var _selectedWorkEmp;
  MyCEmp(var date,var proj, var selectedWorkEmp){
    this.date = date;
    this.proj = proj;
    this._selectedWorkEmp = selectedWorkEmp;
  }
  @override
  Widget build(BuildContext context){
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Empleados"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.arrow_back),onPressed:()async{
              var selectedProj = await DBProvider.db.getAllWorksDate(date);
              Navigator.of(context).pop(MaterialPageRoute(
                builder: (context) => MyCProj(date, selectedProj),
              ));
            }),
          ],
        ),
        body: CelBoxEm(date, proj, _selectedWorkEmp),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class CelBoxWidgetEmp extends State<CelBoxEm> {
  var date;
  var proj;
  var _workss = List<WorksModels>();
  final forrkey = GlobalKey<FormState>();
  var _horasTrabajadas;
  CelBoxWidgetEmp(var date,var proj, var selectedWorkEmp){
    this.date = date;
    this.proj = proj;
    _horasTrabajadas = null;
    this._workss = selectedWorkEmp;
    print("esta en el proyecto $proj");
  }
  @override
  Widget build(BuildContext context) {
    return _buildProjects();
  }

  Widget _buildProjects() {
    return FutureBuilder<List<Employee>>(
        future: DBProvider.db.getAllEmployees(),
        builder: (BuildContext context, AsyncSnapshot<List<Employee>> snappshot){
          if(!snappshot.hasData)  return Center(child: CircularProgressIndicator(),);
          final employees = snappshot.data;

          if(employees.length == 0) return Center(child: Text("no hay informacion"),);
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, i) => ListTile(
              leading: Icon(Icons.person, color: Colors.blueAccent,),
              title: Text(employees[i].namesEm),
              trailing: Icon((isThereEmp(employees[i].idEmployees))? Icons.check_box:Icons.check_box_outline_blank,
                color: Colors.blue,
              ),
              subtitle: Text((isThereEmp(employees[i].idEmployees))? "horas trabajadas ${hoursEmp(employees[i].idEmployees)}":"no trabajo"),
              onTap: () {
                setState(() {
                  final a = isThereEmp(employees[i].idEmployees);
                  if (a==false) {
                    _aniadirEmployee(context, employees[i].idEmployees);
                  } else {
                    _quitarEmployee(context, employees[i].idEmployees);
                  }
                });
              },
              onLongPress: (){

              },
            ),
          );
        }
    );
  }
  bool isThereEmp(int idEmp){
    bool res = false;
    for(int i = 0; i < _workss.length; i++){
      if(_workss[i].isEqProEmp(date, proj, idEmp)==true){
        res = true;
      }
    }
    return res;
  }
  int hoursEmp(int idEmp){
    int res = 0;
    for(int i = 0; i < _workss.length; i++){
      if(_workss[i].isEqProEmp(date, proj, idEmp)==true){
        res = _workss[i].hoursWorkEmployees;
      }
    }
    return res;
  }
  void deleteWork(int idEmp){
    bool res = false;
    int i = 0;
    while(i < _workss.length && res == false){
      if(_workss[i].isEqProEmp(date, proj, idEmp)==true){
        _workss.removeAt(i);
        res = true;
      }
      i++;
    }
  }
  void _aniadirEmployee(BuildContext context, int id){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text("Horas trabajadas"),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            content: Form(
              key: forrkey,
              child:Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.attach_money,
                          color: Colors.black,
                        ),
                        hintText: "Horas trabajadas",
                      ),
                      validator: (input) => input.contains("a")? 'no letras please':null,
                      onSaved: (input) => _horasTrabajadas = int.parse(input),
                    ),
                  ),
                  Align(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      child: Text("Si"),
                      onPressed: () {
                        if(forrkey.currentState.validate()) {
                          forrkey.currentState.save();
                          if (_horasTrabajadas != null) {
                            final work = WorksModels(idDates: this.date, idProjects: proj,idEmployees: id,hoursWorkEmployees: _horasTrabajadas);
                            _workss.add(WorksModels(idDates: this.date, idProjects: proj,idEmployees: id,hoursWorkEmployees: _horasTrabajadas));
                            DBProvider.db.nuevoWork(work);
                            _horasTrabajadas = null;
                          }
                        }
                        setState(() {
                          this.context;
                        });
                        Navigator.of(context).pop();
                      },
                      color: Colors.cyan,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  void _quitarEmployee(BuildContext context, int id){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text("Seguro que quiere quitar al empleado?"),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Form(
              key: UniqueKey(),
              child:Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          this.context;
                        });
                      },
                      color: Colors.cyan,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Text("Si"),
                      onPressed: () {
                        deleteWork(id);
                        DBProvider.db.deleteWorkProj(date, proj, id);
                        Navigator.of(context).pop();
                        setState(() {
                          this.context;
                        });
                      },
                      color: Colors.cyan,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
class CelBoxEm extends StatefulWidget {
  var date;
  var proj;
  var _selectedWorkEmp;
  CelBoxEm(var date,var proj,var selectedWorkEmp){
    this.date = date;
    this.proj = proj;
    this._selectedWorkEmp = selectedWorkEmp;
  }
  @override
  CelBoxWidgetEmp createState() => CelBoxWidgetEmp(this.date, this.proj, this._selectedWorkEmp);
}
