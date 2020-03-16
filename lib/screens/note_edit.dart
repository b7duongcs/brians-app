import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/note_providers.dart';

enum NoteMode {
  Editing,
  Adding
}

class NoteEdit extends StatefulWidget {
  final NoteMode noteMode;
  final Map<String, dynamic> note;

  NoteEdit(this.noteMode, this.note);

  @override 
  NoteEditState createState() => NoteEditState();
}

class NoteEditState extends State<NoteEdit> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  List<String> lot = [];
  DateTime _dateTime;
  TimeOfDay _time;
  var selectedTag;

  @override 
  void didChangeDependencies() {
    if (widget.noteMode == NoteMode.Editing) {
    _titleController.text = widget.note['title'];
    _tagController.text = widget.note['tag'];
    _textController.text = widget.note['text'];
    _dateTime = DateTime.parse(widget.note['date'] + ' 00:00:00.000');
    final s = widget.note['time'];
    _time = TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
    }
    super.didChangeDependencies();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          widget.noteMode == NoteMode.Adding? 'Add' : 'Edit'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title'
              ),
            ),
            Container(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FutureBuilder(
                  future: TagProvider.getTagList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final tags = snapshot.data;
                      int total = tags.length;
                      List<String> lotags = [];
                      for (int i = 0; i < total; i++) {
                        lotags.add(tags[i]['tag']);
                      }
                      return DropdownButton(
                        items: lotags.map((value) => DropdownMenuItem(
                          child: Text(value,),
                          value: value,
                        )).toList(), onChanged: 
                        (selectedTagType) {
                          setState(() {
                            selectedTag = selectedTagType;
                          });
                        },
                        value: selectedTag,
                        isExpanded: false,
                        hint: Text('Choose Tag'),
                      );
                    }
                    return CircularProgressIndicator();
                  }
                ),
                  FlatButton(onPressed: ()
                    { 
                      TextEditingController _newTagController = TextEditingController();
                      showDialog(context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Add Tag",
                              style: 
                              TextStyle(color: Colors.grey.shade800),
                              textAlign: TextAlign.center,
                            ),
                            content: TextField(
                              controller: _newTagController,
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                child: Text('Add',
                                style: TextStyle(color: Colors.deepOrange),
                                ),
                                onPressed: 
                                //_newTagController.text == '' ? null :
                                () async {
                                  final tag = _newTagController.text;
                                  await TagProvider.insertTag({'tag' : tag});
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                      );
                    }, 
                    child: Icon(Icons.add)
                  )
              ],
            ),
            Container(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  child: Text('Pick Date'),
                  onPressed: () {
                    showDatePicker(context: context, 
                    initialDate: _dateTime == null? DateTime.now() :
                    _dateTime, 
                    firstDate: DateTime(2020), lastDate: DateTime(2200)
                    ).then((date) {
                      setState((){
                        _dateTime = date;
                      });
                    });
                  },
                ),
                Text(_dateTime == null ? 'No Date' : 
                  _dateTime.toString().substring(0,10)
                ),
              ],
            ),
            Container(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  child: Text('Pick Time'),
                  onPressed: () {
                    showTimePicker(context: context, 
                    initialTime: _time == null? TimeOfDay.now() :
                    _time, 
                    ).then((time) {
                      setState((){
                        _time = time;
                      });
                    });
                  },
                ),
                Text(_time == null ? 'No Time' : 
                  _time.toString().substring(10,15)
                ),
              ],
            ),
            Container(height: 8,),
            TextField(
              maxLines: 5,
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Additional Info'
              ),
            ),
            Container(height: 8,),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
            MaterialButton(
              onPressed: () {
                final title = _titleController.text;
                final tag = selectedTag;
                //final tag = _tagController.text;
                final text = _textController.text;
                final date = _dateTime.toString().substring(0,10);
                final time = _time.toString().substring(10,15);
                if (widget?.noteMode == NoteMode.Adding) {
                  NoteProvider.insertNote({
                      'title' : title,
                      'tag' : tag,
                      'text' : text,
                      'date' : date,
                      'time' : time,
                    });
                } else if (widget?.noteMode == NoteMode.Editing) {
                  NoteProvider.updateNote(
                    {
                      'id': widget.note['id'],
                      'title' : title,
                      'tag' : tag,
                      'text' : text,
                      'date' : date,
                      'time' : time,
                    }
                  );
                }
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.deepOrange,
            ),
            widget.noteMode == NoteMode.Editing ?
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
            child: MaterialButton(
              onPressed: () async {
                await NoteProvider.deleteNote(widget.note['id']);
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                )
              ),
              color: Colors.red,
            )
            )
            : Container()
              ]
            )
          ],
        )
      ),
    );
  }
}