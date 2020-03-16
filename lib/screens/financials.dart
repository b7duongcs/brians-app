import 'package:flutter/material.dart';
import 'package:myapp/providers/fin_providers.dart';
import 'package:myapp/screens/fin_view.dart';
import 'package:myapp/screens/fin_edit.dart';

class FPage extends StatefulWidget {
  @override 
  _FPageState createState() => _FPageState();
}

class _FPageState extends State<FPage> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: FinProvider.getFinList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final fins = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FinView(fins[index]),
                          ),
                        );
                      },
                      onDoubleTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FinEdit(Mode.Editing, fins[index]),
                          ),
                        );
                      },
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text(
                                    'Delete?',
                                    style:
                                        TextStyle(color: Colors.grey.shade800),
                                    textAlign: TextAlign.center,
                                  ),
                                  content: 
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          MaterialButton(
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: Colors.deepOrange),
                                            ),
                                            onPressed: () async {
                                              await FinProvider.deleteFin(
                                                  fins[index]['id']);
                                              setState(() {});
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          MaterialButton(
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  color: Colors.deepOrange),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ]),
                                  //],
                                ));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 22.0, right: 22.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _FinLocation(fins[index]['location']),
                                  _FinTotal(fins[index]['total'])
                                ],
                              ),
                              Container(
                                height: 3,
                              ),
                              Row(
                                children: <Widget>[
                                  _FinDate(fins[index]['date']),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: fins.length,
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FinEdit(Mode.Adding, null)));
          },
          child: Icon(Icons.add),
        ));
  }
}

class _FinLocation extends StatelessWidget {
  final String _loc;

  _FinLocation(this._loc);

  @override
  Widget build(BuildContext context) {
    return Text(
      _loc,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class _FinTotal extends StatelessWidget {
  final double _total;

  _FinTotal(this._total);

  @override 
  Widget build(BuildContext context) {
    return Text(
      'Total Spent: \$' + _total.toString(),
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class _FinDate extends StatelessWidget {
  final String _date;

  _FinDate(this._date);

  @override
  Widget build(BuildContext context) {
    return Text(_date, style: TextStyle(color: Colors.grey.shade600));
  }
}