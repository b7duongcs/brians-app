import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:myapp/inherited_widgets/inherited_widgets.dart';
import 'package:myapp/providers/note_providers.dart';
import 'note_edit.dart';
import 'note_view.dart';

class RPage extends StatefulWidget {

  @override 
  RPageState createState() {
    return new RPageState();
  }
}

class RPageState extends State<RPage> {

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: NoteProvider.getNoteList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final notes = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                 return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                        MaterialPageRoute(builder: (context) => NoteView(notes[index]),),
                    );
                  },
                  onDoubleTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NoteEdit(NoteMode.Editing, notes[index]),),
                    );
                  },
                  /*onLongPress: () {
                    showDialog(context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Text('Delete?',
                          style: TextStyle(
                            color: Colors.grey.shade800
                          ),
                       ),
                        //content: Icon(Icons.delete),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Yes',
                              style: TextStyle(
                                color: Colors.deepOrange
                              ),
                            ),
                            onPressed: () async {
                              await NoteProvider.deleteNote(notes[index]);
                              Navigator.of(context).pop();
                            },
                            ),
                          CupertinoDialogAction(
                            child: Text('No',
                              style: TextStyle(
                                color: Colors.deepOrange
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            )
                            ],
                            )
                      );
                  },*/
            child: Card(
             child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 22.0, right: 22.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _NoteTitle(notes[index]['title']),
                        _NoteTag(notes[index]['tag'])
                      ],
                     ),
                    Container(height: 3,),
                    Row(
                      children: <Widget>[
                        _NoteDate(notes[index]['date']),
                        Text(' | '),
                        _NoteTime(notes[index]['time']),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: notes.length,
      );
          }
          return Center(child: CircularProgressIndicator());
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteEdit(NoteMode.Adding, null))
          );
        },
        child: Icon(Icons.add),
      )
    );
  }
}

class _NoteTitle extends StatelessWidget {

  final String _title;

  _NoteTitle(this._title);

  @override 
  Widget build(BuildContext context) {
    return Text(_title,
            style: TextStyle(
              fontWeight: FontWeight.bold
              ),
            );
  }
}

class _NoteTag extends StatelessWidget {

  final String _tag;

  _NoteTag(this._tag);

  @override 
  Widget build(BuildContext context) {
    return Text(_tag,);
  }
}

class _NoteDate extends StatelessWidget {

  final String _date;

  _NoteDate(this._date);

  @override 
  Widget build(BuildContext context) {
    return Text(_date,
      style: TextStyle(
      color: Colors.grey.shade600)
    );
  }
}

class _NoteTime extends StatelessWidget {

  final String _time;

  _NoteTime(this._time);

  @override 
  Widget build(BuildContext context) {
    return Text(_time,
      style: TextStyle(
      color: Colors.grey.shade600)
    );
  }
}
