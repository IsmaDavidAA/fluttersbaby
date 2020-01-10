import 'package:flutter/material.dart';
/*
class ListBox extends State<Boxes> {
  final _suggestions = <Box>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(

        padding: const EdgeInsets.all(10.0),
        itemBuilder: /*1*/ (context, i) { /*3*/
          if(i < 14) {
            print(i);
            _suggestions.add(Box()); /*4*/
            return Box();
          }else return null;

        });
  }
}
class Boxes extends StatefulWidget {
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
        color: Colors.cyanAccent,
        child: Text(
            'Enabled Button $date',
            style: TextStyle(fontSize: 20)
        ),
    );
  }
}
*/