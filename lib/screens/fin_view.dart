import 'package:flutter/material.dart';

class FinView extends StatefulWidget {
  final Map<String, dynamic> fin;

  FinView(this.fin);

  @override 
  FinViewState createState() => FinViewState();
}

class FinViewState extends State<FinView> {

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fin['date']),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(widget.fin['location'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          //widget.fin['food'] == 0 ? null : 
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text('Food: \$' + widget.fin['food'].toString(),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 25
              )
            )
          ),
          //widget.fin['school'] == 0 ? null : 
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text('School: \$' + widget.fin['school'].toString(),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 25
              )
            )
          ),
          //widget.fin['bills'] == 0 ? null : 
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text('Bills: \$' + widget.fin['bills'].toString(),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 25
              )
            )
          ),
          //widget.fin['other'] == 0 ? null : 
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text('Other: \$' + widget.fin['other'].toString(),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 25
              )
            )
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text('Total: \$' + widget.fin['total'].toString(),
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 25
              )
            )
          ),
        ]
      )
    );
  }
}

