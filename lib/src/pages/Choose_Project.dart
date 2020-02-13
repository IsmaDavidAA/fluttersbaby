
import 'package:flutter/material.dart';
import 'package:fluttersbaby/src/models/worked_models.dart';
import 'package:fluttersbaby/src/pages/Choose_Projects.dart';
import 'package:fluttersbaby/src/pages/home_page.dart';
import 'package:fluttersbaby/src/providers/db_provider.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttersbaby/src/bloc.navigation_bloc/navigation_bloc.dart';

class MyCProj extends StatelessWidget with NavigationStates{
  Date date;
  var _workss;
  var wow;
  MyCProj(Date date){
    this.date = date;
    wow = FutureBuilder<List<WorksModels>>(
        future: DBProvider.db.getAllWorksDate(date.idDates),
        builder: (BuildContext context, AsyncSnapshot<List<WorksModels>> snappshot){
          print("loooooooooool");
          if(!snappshot.hasData)  return null;
          _workss = snappshot.data;
          return null;
        }
    );
//    DBProvider.db.deleteAllWork();
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
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
        body: CelBox(date,_workss),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class CelBoxWidget extends State<CelBox> {
  Date date;
  var _workss = List<WorksModels>();
  final forrkey = GlobalKey<FormState>();
  CelBoxWidget(Date date, var futureBuildr){
    this.date = date;

    if(futureBuildr == null) print("gg ");
    else print("we wont");
    print("${_workss.length} deberia ser");
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
                    final work = WorksModels(idDates: this.date.idDates, idProjects: projects[i].idProjects);
                    _workss.add(WorksModels(idDates: date.idDates, idProjects: projects[i].idProjects));
                    DBProvider.db.nuevoWork(work);
                  } else {
                    deleteWork(projects[i].idProjects);
                    DBProvider.db.deleteWork(date.idDates, projects[i].idProjects);
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
  bool isThereWork(int idProj){
    bool res = false;
    for(int i = 0; i < _workss.length; i++){
      if(_workss[i].isEqP(date.idDates, idProj)){
        res = true;
      }
    }
    return res;
  }
  void deleteWork(int idProj){
    bool res = false;
    int i = 0;
    while(i < _workss.length && res == false){
      if(_workss[i].isEqP(date.idDates, idProj)==true){
        _workss.removeAt(i);
        res = true;
      }
      i++;
    }
  }
}
class CelBox extends StatefulWidget {
  Date date;
  var _wokss;
  CelBox(Date date,var w){
    this.date = date;
    this._wokss = w;
  }
  @override
  CelBoxWidget createState() => CelBoxWidget(this.date, this._wokss);
}
