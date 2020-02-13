
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final fkey =GlobalKey<FormState>();
  var _horas = null;
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.check_box: Icons.check_box_outline_blank,
        color: alreadySaved ? Colors.blueAccent : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
  // #enddocregion RWS-build

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                onTap: () => _EditHours(context, 8),
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  void _EditHours(BuildContext context, int id){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text("Horas trabajadas"),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            content: Form(
              key: fkey,
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
                        hintText: "horas trabajadas",
                      ),
                      validator: (input) => input.contains(" ")? 'no letras please':null,
                      onSaved: (input) => _horas = int.parse(input),
                    ),
                  ),
                  Align(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      child: Text("Ok"),
                      onPressed: () {
                        if(fkey.currentState.validate()) {
                          fkey.currentState.save();
                          if (_horas != null) {
                             print("lolaso");
                            _horas = null;
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
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

