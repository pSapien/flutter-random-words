import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _savedWords = [];

  Widget _buildTitle(WordPair word) =>
      Text(word.asPascalCase, style: _biggerFont);

  Widget _buildSuggestions() {
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return Divider();

      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }

      final word = _suggestions[index];
      final isSaved = _savedWords.contains(word);

      return ListTile(
        title: _buildTitle(word),
        trailing: Icon(
          isSaved ? Icons.favorite : Icons.favorite_border,
          color: isSaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (isSaved) {
              _savedWords.remove(word);
            } else {
              _savedWords.add(word);
            }
          });
        },
      );
    });
  }

  void _onSaved() {
    print('_onSaved');
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        final tiles = _savedWords.map((e) => ListTile(title: _buildTitle(e)));
        final divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();

        return Scaffold(
          appBar: AppBar(title: Text('Saved')),
          body: ListView(children: divided),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Words Generator'),
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _onSaved)],
      ),
      body: _buildSuggestions(),
    );
  }
}
