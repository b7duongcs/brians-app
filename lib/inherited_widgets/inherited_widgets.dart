import 'package:flutter/material.dart';

class TagInheritedWidget extends InheritedWidget {

  final tags = [
    {
      'tag' : 'Math 136'
    },
    {
      'tag' : 'CS 136'
    }
  ];

  TagInheritedWidget(Widget child) : super(child: child);

  static TagInheritedWidget of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<TagInheritedWidget>());
  }

  @override 
  bool updateShouldNotify(TagInheritedWidget oldWidget) {
    return oldWidget.tags != tags;
  }
}

class NoteInheritedWidget extends InheritedWidget {

  final notes = [
      {
        'title': 'sasfsafsafsafsa',
        'tag': 'Math',
        'text': 'saasfasfasf',
        'date': '2020-10-08',
        'time': '23:44'
      },
      {
        'title': 'someTitle',
        'tag': 'Math',
        'text': 'saasfsafasfafssaff',
        'date': '2020-10-08',
        'time': '23:44'
      },
      {
        'title': 'Title',
        'tag': 'Math',
        'text': 'saaaogodngodgf',
        'date': '2020-10-08',
        'time': '23:44'
      }
    ];

  NoteInheritedWidget(Widget child) : super(child: child);

  static NoteInheritedWidget of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<NoteInheritedWidget>());
  }

  @override 
  bool updateShouldNotify(NoteInheritedWidget oldWidget) {
    return oldWidget.notes != notes;
  }
}