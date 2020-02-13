import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttersbaby/src/models/Employees_model.dart';
import 'package:fluttersbaby/src/providers/db_provider.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class Employees extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
//    DBProvider.db.deleteAllEst();
    return ListVie();
  }

}

class ListVie extends StatefulWidget{
  @override
  ListViewEm createState() => ListViewEm();
}
class ListViewEm extends State<ListVie> {
  String _nuevoEmp;
  int _nuevoSueldo;
  final formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: ListEmpl(),
          padding: const EdgeInsets.only(bottom: 35.0,top: 35.0),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.blueAccent,
            label: Text("Aniadir"),
            icon: Icon(Icons.add),
            onPressed: () => _employeeRegister(context)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
  void _employeeRegister(BuildContext context){
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
}

class ListEmpl extends StatefulWidget{
  @override
  ListEmp createState() => ListEmp();
}
class ListEmp extends State<ListEmpl>{
  var _nuevoEmp, _nuevoSueldo;
  final formmkey =GlobalKey<FormState>();
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
          itemBuilder: (context, i) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) => _employeeDelete(context, employees[i].idEmployees),
              child: ListTile(
                leading: Icon(Icons.person_pin, color: Theme.of(context).primaryColor,),
                title: Text(employees[i].namesEm),
                trailing: Icon(Icons.edit),
                subtitle: Text(getCostoHora(employees[i].sueldosHora)),
                onTap: ()=> _employeeEdit(context, employees[i].idEmployees),
              ),
          ),

        );
      }
    );
  }
  String getCostoHora(int cos){
    return "$cos Bs";
  }
  void _employeeDelete(BuildContext context, int id){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text("Seguro que quiere eliminar al empleado?"),
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
                      child: Text("Cancel"),
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
                      child: Text("Ok"),
                      onPressed: () {
                        DBProvider.db.deleteEmployee(id);
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
  void _employeeEdit(BuildContext context, int id){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text("Nombre empleado"),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            content: Form(
              key: formmkey,
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
                        if(formmkey.currentState.validate()) {
                          formmkey.currentState.save();
                          if (_nuevoEmp != null) {
                            final emp = Employee(idEmployees: id,namesEm: _nuevoEmp,sueldosHora: _nuevoSueldo);
                            DBProvider.db.updateEmployee(emp);
                            _nuevoEmp = null;
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
}


