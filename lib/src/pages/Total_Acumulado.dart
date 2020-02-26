import 'package:flutter/material.dart';
import 'package:fluttersbaby/src/providers/db_provider.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';

class TotalAcumulado extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    return TotalAcu();
  }

}
class TotalAcu extends StatefulWidget{
  @override
  ListTotalAcu createState() => ListTotalAcu();
}
class ListTotalAcu extends State<TotalAcu> {
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
      ),
    );
  }
}
class ListProj extends StatefulWidget{
  @override
  ListProje createState() => ListProje();
}
class ListProje extends State<ListProj>{
  final forrkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Employee>>(
        future: DBProvider.db.totalaPagarPorEmpleado(),
        builder: (BuildContext context, AsyncSnapshot<List<Employee>> snappshot){
          if(!snappshot.hasData)  return Center(child: CircularProgressIndicator(),);
          final employeesSueldo = snappshot.data;

          if(employeesSueldo.length == 0) return Center(child: Text("no hay informacion"),);

          return ListView.builder(
            itemCount: employeesSueldo.length,
            itemBuilder: (context, i) => ListTile(
              key: UniqueKey(),
              leading: Icon(Icons.business, color: Theme.of(context).primaryColor,),
              title: Text(employeesSueldo[i].namesEm),
              trailing: Icon(Icons.attach_money),
              subtitle: Text("${employeesSueldo[i].sueldosHora}"),
            ),
          );
        }
    );
  }
}