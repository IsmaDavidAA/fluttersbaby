import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttersbaby/src/models/Employees_model.dart';
import 'package:fluttersbaby/src/providers/db_provider.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class Employees extends StatelessWidget with NavigationStates {
  String _nuevoEmp;
  int _nuevoSueldo;
  final formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: ListEmp(),
          padding: const EdgeInsets.only(bottom: 35.0,top: 35.0),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blueAccent,
          label: Text("Aniadir"),
          icon: Icon(Icons.add),
          onPressed: () => _EmployeeRegister(context)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
  void _EmployeeRegister(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){

        return AlertDialog(
          title: Text("Nombre empleado"),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          content: Form(
            key: formkey,
            child:Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_pin,
                      color: Colors.black,
                    ),
                    hintText: "nombre empleado",
                  ),
                  validator: (input) => input.contains("1")? 'no numbers please':null,
                  onSaved: (input) => _nuevoEmp = input,
                ),
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.attach_money,
                      color: Colors.black,
                    ),
                    hintText: "sueldo hora",
                  ),
                  validator: (input) => input.contains("a")? 'no letras please':null,
                  onSaved: (input) => _nuevoSueldo = int.parse(input),
                ),
              ),
              Align(
//                alignment: Alignment(1,0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: Text("Ok"),
                  onPressed: () {
                    if(formkey.currentState.validate()) {
                      formkey.currentState.save();
                      if (_nuevoEmp != null) {
                        final emp = Employee(namesEm: _nuevoEmp,sueldosHora: _nuevoSueldo);
                        DBProvider.db.nuevoEmployee(emp);
                        _nuevoEmp = null;
                      }
                    }
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
}
class ListEmp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Employee>>(
      future: DBProvider.db.getAllEmployees(),
      builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot){
        if(!snapshot.hasData)  return Center(child: CircularProgressIndicator(),);
        final employees = snapshot.data;

        if(employees.length == 0) return Center(child: Text("no hay informacion"),);

        return ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context, i) => ListTile(
            leading: Icon(Icons.person_pin, color: Theme.of(context).primaryColor,),
            title: Text(employees[i].namesEm),
            trailing: Icon(Icons.edit),
            subtitle: Text(getCostoHora(employees[i].sueldosHora)),
          ),
        );
      }
    );
  }
  String getCostoHora(int cos){
    return "$cos Bs";
  }
}