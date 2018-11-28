import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';

class Native extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        theme: new ThemeData(
          primaryColor: Colors.blue,
        ),
        home: new RandomWords(),
      ),
      onWillPop: null,
    );
  }


//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Startup Name Generator',
//      theme: new ThemeData(
//        primaryColor: Colors.blue,
//      ),
//      home: new RandomWords(),
//    );
//  }
}

class RandomWords extends StatefulWidget {
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  Widget build (BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Text(
              'Flutter',
              style: Theme.of(context).primaryTextTheme.title,
            ),
            searchAction: _searchPush,
            pushAction :_pushSaved,
          ),

          new Expanded(
            child: new Center(
              child: _buildSuggestions(),
            ),
          ),
        ],
      ),
    );

    /*
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
    */
  }

  Widget _buildSuggestions(){
    return new ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, i){
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
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

  void _pushSaved() {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {

              final tiles = _saved.map(
                    (pair) {
                  return new ListTile (
                    title: new Text (
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  );
                },
              );

              final divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
              )
                  .toList();

              return new Scaffold(
                appBar: new AppBar(
                  title: new Text('Saved Suggestions'),
                ),
                body: new ListView(children:divided),
              );
            }
        )
    );
  }

  void _searchPush(){
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

}

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title, this.pushAction, this.searchAction});

  final Widget title;
  final VoidCallback pushAction;
  final VoidCallback searchAction;

  Widget build(BuildContext context) {
    return new Container(
      height: 64.0,
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      child: new Row(
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.arrow_back),
            tooltip: 'Search',
            onPressed: searchAction,
          ),

          new Expanded(
            child: new Center(
              child: title,
            ),
          ),

          new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'menu',
            onPressed: pushAction,
          ),
        ],
      ),
    );
  }
}