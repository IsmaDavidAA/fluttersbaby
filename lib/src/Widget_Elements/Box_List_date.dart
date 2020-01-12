//import 'package:flutter/material.dart';
/*
class ListBox extends State<Boxes> {
  final _suggestions = <Box>[];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 30.0,top: 60.0),
      child:Container(
        padding: const EdgeInsets.only(right: 0.0,top: 15.0),
        color: Color.fromARGB(150,95,158,160),
        child: _buildSuggestions(),
      )
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if(i < 14) {
            _suggestions.add(Box());
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
        color: Color.fromARGB(190, 37, 109, 123),
        child: Text(
            'uwu 7u7 XD $date',
            style: TextStyle(fontSize: 20,
                      color: Colors.white
                    )
        ),
    );
  }
}
*/