import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class ListBox extends State<Boxes> {
  final _suggestions = <Box>[];
  final _dateC = false;
  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.only(right: 40.0,top: 70.0),
        child:Container(
          padding: const EdgeInsets.only(right: 0.0,top: 15.0),
          color: Color.fromARGB(150,95,158,160),
          child: _buildSuggestions(),
        )
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
            _suggestions.add(Box());
            return Box();
          }else return null;
        }
    );
  }

}
class Boxes extends StatefulWidget with NavigationStates{
  @override
  ListBox createState() => ListBox();
}

class Box extends StatefulWidget{
  @override
  BoxWitget createState() {
    return BoxWitget();
  }
}
class BoxWitget extends State<Box>{
  String date;
  @override
  Widget build(BuildContext context) {
    date = "lol";
    return RaisedButton(
      onPressed: () {},
      color: Color.fromARGB(190, 37, 109, 123),
      child: Text(
          ' $date veamos si agrego mas textooooo',
          style: TextStyle(fontSize: 18,
              color: Colors.white
          ),
      ),
    );
  }
}

