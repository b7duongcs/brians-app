import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  final Map<String, dynamic> note;

  NoteView(this.note);

  @override 
  NoteViewState createState() => NoteViewState();
}

class NoteViewState extends State<NoteView> {

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note['tag']),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(widget.note['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Text(widget.note['date'],
              style: TextStyle(
                color: Colors.grey.shade600
              )
            )
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Text(widget.note['time'],
              style: TextStyle(
                color: Colors.grey.shade600
              )
            )
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text('Additional Info:',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 20
              )
            )
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Text(widget.note['text'],
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 15
              )
            )
          )
        ]
      )
    );
  }
}

