import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersbaby/src/models/days_model.dart';
import 'package:fluttersbaby/src/pages/Choose_Project.dart';
import 'package:fluttersbaby/src/pages/Choose_Projects.dart';
import 'package:fluttersbaby/src/pages/List_Proyects_page.dart';
import 'package:fluttersbaby/src/providers/db_provider.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class ListBox extends State<Boxes> {
  final _suggestions = <Box>[];
  Date today;
  ListBox(){
    today = new Date(dates: "${generDay(DateTime.now().day)}-${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}");  
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 40.0,top: 70.0),
        child:Container(
          padding: const EdgeInsets.only(right: 0.0,top: 15.0),
          color: Color.fromARGB(150,95,158,160),
          child: _buildSuggestions(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text(''),
        icon: Icon(Icons.settings_backup_restore),
        backgroundColor: Colors.black,
      ),
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.only(right: 24, left: 24,top: 0,bottom: 0),
        itemBuilder: (context, i) {
          SizedBox(
            height: 100,
          );
          if(i < 14) {
            _suggestions.add(Box(i,today));
            return Box(i,today);
          }else return null;
        }
    );
  }
  String generDay(int wk){
    if(wk ==1 )  return "Lunes";
    if(wk ==2 )  return "Martes";
    if(wk ==3 )  return "Miercoles";
    if(wk ==4 )  return "Jueves";
    if(wk ==5 )  return "Viernes";
    if(wk ==6 )  return "Sabado";
    else return "Domingo";
  }
}
class Boxes extends StatefulWidget{
  @override
  ListBox createState() => ListBox();
}

class Box extends StatefulWidget{
  int date;
  Date today;
  Box(int date, Date today){
    this.date = date;
    this.today = today;
  }
  @override
  BoxWitget createState() {
    return BoxWitget(date,today);
  }
}
class Boxx extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Est>(
        future: DBProvider.db.getEst(),
        builder: (BuildContext context, AsyncSnapshot<Est> snappshot) {
          if (!snappshot.hasData)  return Welc();
          final est = snappshot.data;
          if(est.estado == 0) return Center(child: Text("elija una fecha"),);
          return Boxes();
        }
    );
  }
}

class Welc extends StatefulWidget {
  @override
  _WelcState createState() => _WelcState();
}

class _WelcState extends State<Welc> {
  var _dateTime;
  var cont=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_dateTime == null ? 'Aun no tiene fecha de inicio' : _dateTime.toString()),
            RaisedButton(
              child: Text('Escoger fecha de inicio'),
              onPressed: () {
                showDatePicker(
                    context: context,
                    initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                    firstDate: DateTime(2018),
                    lastDate: DateTime(2021),
                ).then((date) {
                  setState(() {
                    _dateTime = "${date.day}-${date.month}-${date.year}-${date.weekday}";
                    if(_dateTime != null && cont == 0){
                      cont = 1;
                      final dat = Est(estado: 1);
                      DBProvider.db.nuevoEst(dat);
                      llenarDays();
                    }
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
  llenarDays(){
    List<String> res = _dateTime.split("-");
    int d = int.parse(res[0]) - 1;
    int m = int.parse(res[1]);
    int y = int.parse(res[2]);
    int dw = int.parse(res[3]);
    for(var i=0;i<14;i++){
      var newDate;
      if(m <8) {
        if (m % 2 == 0) {
          if (m == 2) {
            if (d < 29) {
              d++;
            } else {
              d = 1;
              m++;
            }
          } else {
            if (d < 30) {
              d++;
            } else {
              d = 1;
              m++;
            }
          }
        } else {
          if (d < 31) {
            d++;
          } else {
            d = 1;
            m++;
          }
        }
      }else{
        if (m % 2 == 0) {
          if (m == 12) {
            if (d < 31) {
              d++;
            } else {
              d = 1;
              m++;
              y++;
            }
          } else {
            if (d < 31) {
              d++;
            } else {
              d = 1;
              m++;
            }
          }
        } else {
          if (d < 30) {
            d++;
          } else {
            d = 1;
            m++;
          }
        }
      }
      var r = generDay(dw);
      newDate = Date(idDates: i,dates: "$r-$d-$m-$y");
      DBProvider.db.nuevoDate(newDate);
      if(dw < 7){
        dw++;
      }else{
        dw=1;
      }
    }
  }
  String generDay(int wk){
    if(wk ==1 )  return "Lunes";
    if(wk ==2 )  return "Martes";
    if(wk ==3 )  return "Miercoles";
    if(wk ==4 )  return "Jueves";
    if(wk ==5 )  return "Viernes";
    if(wk ==6 )  return "Sabado";
    else return "Domingo";
  }
}
class BoxWitget extends State<Box>{
  int date;
  Date today;
  BoxWitget(int date, Date today){
    this.date = date;
    this.today = today;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Date>(
        future: DBProvider.db.getDateIdDates(date),
        builder: (BuildContext context, AsyncSnapshot<Date> snappshot) {
          if (!snappshot.hasData)  return Center(child: CircularProgressIndicator(),);
          final dat = snappshot.data;
          return RaisedButton(
            onPressed: () async{
              var workProject = await DBProvider.db.getAllWorksDate(dat.idDates);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyCProj(dat.idDates, workProject),
              ));
            },
            color: (!(today.dates == dat.dates))? Color.fromARGB(190, 37, 109, 123): Color.fromARGB(10, 37, 109, 13),
            child: Column(
              children: <Widget>[
                Text("${dat.dates}",
                    style: TextStyle(fontSize: 18,
                      color: Colors.white,)
                ),
                
              ],
            ),
          );
        }
    );
  }
}



