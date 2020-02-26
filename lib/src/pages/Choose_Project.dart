
import 'package:flutter/material.dart';
import 'package:fluttersbaby/src/models/worked_models.dart';
import 'package:fluttersbaby/src/pages/Choose_Employees.dart';
import 'package:fluttersbaby/src/pages/home_page.dart';
import 'package:fluttersbaby/src/providers/db_provider.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttersbaby/src/bloc.navigation_bloc/navigation_bloc.dart';

class MyCProj extends StatelessWidget with NavigationStates{
  var date;
  var _workss;
  MyCProj(var date, var wow){
    this.date = date;
    this._workss = wow;
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
          title: Text("Proyectos"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
              Navigator.of(context).pop(MaterialPageRoute(
                builder: (context) => Boxes(),
              ));
            }),
          ],
        ),
        body: CelBox(date, _workss),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class CelBoxWidget extends State<CelBox> {
  var date;
  var _workss = List<WorksModels>();
  final forrkey = GlobalKey<FormState>();
  CelBoxWidget(var date, var wow){
    this.date = date;
    this._workss = wow;
  }
  @override
  Widget build(BuildContext context) {
    return _buildProjects();
  }

  Widget _buildProjects() {
    return FutureBuilder<List<Project>>(
        future: DBProvider.db.getAllProjects(),
        builder: (BuildContext context, AsyncSnapshot<List<Project>> snappshot){
          if(!snappshot.hasData)  return Center(child: CircularProgressIndicator(),);
          final projects = snappshot.data;

          if(projects.length == 0) return Center(child: Text("no hay informacion"),);
          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, i) => ListTile(
              leading: Icon(Icons.business, color: Colors.blueAccent,),
              title: Text(projects[i].namesPro),
              trailing: Icon((isThereWork(projects[i].idProjects))? Icons.check_box:Icons.check_box_outline_blank,
                color: Colors.blue,
              ),
              subtitle: Text(projects[i].namesPro),
              onTap: () {
                setState(() {
                  final a = isThereWork(projects[i].idProjects);
                  if (a==false) {
                    final work = WorksModels(idDates: this.date, idProjects: projects[i].idProjects);
                    _workss.add(WorksModels(idDates: date, idProjects: projects[i].idProjects));
                    DBProvider.db.nuevoWork(work);
                  } else {
                    _quitarProyecto(context, projects[i].idProjects);
                  }
                });
              },
              onLongPress: () async{
                var selectedEmp = await DBProvider.db.getAllWorksDateProj(date,projects[i].idProjects);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyCEmp(date, projects[i].idProjects,selectedEmp),
                ));
              },
            ),
          );
        }
    );
  }
  bool isThereWork(int idProj){
    bool res = false;
    for(int i = 0; i < _workss.length; i++){
      if(_workss[i].isEqP(date, idProj)){
        res = true;
      }
    }
    return res;
  }
  void deleteWork(int idProj){
    bool res = false;
    int i = 0;
    while(i < _workss.length && res == false){
      if(_workss[i].isEqP(date, idProj)==true){
        _workss.removeAt(i);
        res = true;
      }
      i++;
    }
  }
  void _quitarProyecto(BuildContext context, int id){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text("Seguro que quiere quitar el proyecto?"),
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
                        DBProvider.db.deleteWorks(date, id);
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
class CelBox extends StatefulWidget {
  var date;
  var _wokss;
  CelBox(var date,var w){
    this.date = date;
    this._wokss = w;
  }
  @override
  CelBoxWidget createState() => CelBoxWidget(this.date, this._wokss);
}
