import 'package:flutter/material.dart';
import 'package:fluttersbaby/src/providers/db_provider.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';

class Projects extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    DBProvider.db.deleteAllWork();
    return ListVip();
  }

}
class ListVip extends StatefulWidget{
  @override
  ListViewPro createState() => ListViewPro();
}
class ListViewPro extends State<ListVip> {
  String _nuevoProj;
  final forkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: ListProj(),
          padding: const EdgeInsets.only(bottom: 35.0,top: 35.0),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.blueAccent,
            label: Text("Aniadir"),
            icon: Icon(Icons.add),
            onPressed: () => _ProjectRegister(context)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
  void _ProjectRegister(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){

          return AlertDialog(
            title: Text("Nombre Proyecto"),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            content: Form(
              key: forkey,
              child:Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.business,
                          color: Colors.black,
                        ),
                        hintText: "nombre proyecto",
                      ),
                      validator: (input) => input.contains("1")? 'no numbers please':null,
                      onSaved: (input) => _nuevoProj = input,
                    ),
                  ),
                  Align(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Text("Ok"),
                      onPressed: () {
                        if(forkey.currentState.validate()) {
                          forkey.currentState.save();
                          if (_nuevoProj != null) {
                            final pro = Project(namesPro: _nuevoProj,idEmployees: null);
                            DBProvider.db.nuevoProject(pro);
                          }
                          _nuevoProj = null;
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
class ListProj extends StatefulWidget{
  @override
  ListProje createState() => ListProje();
}
class ListProje extends State<ListProj>{
  String _nuevoProj;
  final forrkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
        future: DBProvider.db.getAllProjects(),
        builder: (BuildContext context, AsyncSnapshot<List<Project>> snappshot){
          if(!snappshot.hasData)  return Center(child: CircularProgressIndicator(),);
          final projects = snappshot.data;

          if(projects.length == 0) return Center(child: Text("no hay informacion"),);

          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, i) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) => _projectDelete(context, projects[i].idProjects),
              child: ListTile(
              leading: Icon(Icons.business, color: Theme.of(context).primaryColor,),
              title: Text(projects[i].namesPro),
              trailing: Icon(Icons.edit),
              onTap: () => _employeeEdit(context, projects[i].idProjects),
              ),
            ),
          );
        }
    );
  }


  void _projectDelete(BuildContext context, int id){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text("Seguro que quiere eliminar el proyecto?"),
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
                        DBProvider.db.deleteProject(id);
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
            title: Text("Nombre Proyecto"),
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
                          Icons.business,
                          color: Colors.black,
                        ),
                        hintText: "nombre proyecto",
                      ),
                      validator: (input) => input.contains("1")? 'no numbers please':null,
                      onSaved: (input) => _nuevoProj = input,
                    ),
                  ),
                  Align(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      child: Text("Ok"),
                      onPressed: () {
                        if(forrkey.currentState.validate()) {
                          forrkey.currentState.save();
                          if (_nuevoProj != null) {
                            final proj = Project(idProjects: id,namesPro: _nuevoProj);
                            DBProvider.db.updateProject(proj);
                            _nuevoProj = null;
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