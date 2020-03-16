import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/providers/fin_providers.dart';

enum Mode {
  Editing,
  Adding
}

class FinEdit extends StatefulWidget {
  final Mode mode;
  final Map<String, dynamic> fin;

  FinEdit(this.mode, this.fin);

  @override 
  FinEditState createState() => FinEditState();
}

class FinEditState extends State<FinEdit> {

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _billsController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  double food = 0;
  double school = 0;
  double bills = 0;
  double other = 0;
  DateTime _dateTime;

  @override 
  void didChangeDependencies() {
    if (widget.mode == Mode.Editing) {
      food = widget.fin['food'];
      school = widget.fin['school'];
      bills = widget.fin['bills'];
      other = widget.fin['other'];
    _locationController.text = widget.fin['location'];
    _foodController.text = food.toString();
    _schoolController.text = school.toString();
    _billsController.text = bills.toString();
    _otherController.text = other.toString();
    _dateTime = DateTime.parse(widget.fin['date'] + ' 00:00:00.000');
    }
    super.didChangeDependencies();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          widget.mode == Mode.Adding? 'Add' : 'Edit'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: 'Location'
              ),
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
                Text(
                  'Food Purchases:',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  width: 70,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _foodController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    new BlacklistingTextInputFormatter(new RegExp('[\\,|\\ |\\-]')),
                  ],
                  onSubmitted: (str) => setState((){
                    food = (double.parse(str));
                  }
                  ),
                )
                )
              ],
            ),
            Container(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'School Purchases:',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  width: 70,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _schoolController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    new BlacklistingTextInputFormatter(new RegExp('[\\,|\\ |\\-]')),
                  ],
                  onSubmitted: (str) => setState((){
                    school = (double.parse(str));
                  }
                  ),
                )
                )
              ],
            ),
            Container(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Bills:',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  width: 70,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _billsController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    new BlacklistingTextInputFormatter(new RegExp('[\\,|\\ |\\-]')),
                  ],
                  onSubmitted: (str) => setState((){
                    bills = (double.parse(str));
                  }
                  ),
                )
                )
              ],
            ),
            Container(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Other Purchases:',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  width: 70,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _otherController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    new BlacklistingTextInputFormatter(new RegExp('[\\,|\\ |\\-]')),
                  ],
                  onSubmitted: (str) => setState((){
                    other = (double.parse(str));
                  }
                  ),
                )
                )
              ],
            ),
            Container(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '\$' + (food + school + bills + other).toString(),
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Container(height: 8,),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
            MaterialButton(
              onPressed: () {
                final location = _locationController.text;
                final date = _dateTime.toString().substring(0,10);
                if (widget?.mode == Mode.Adding) {
                  FinProvider.insertFin({
                      'location' : location,
                      'date' : date,
                      'food' : food,
                      'school' : school,
                      'bills' : bills,
                      'other' : other,
                      'total' : food + school + bills + other
                    });
                } else if (widget?.mode == Mode.Editing) {
                  FinProvider.updateFin(
                    {
                      'id': widget.fin['id'],
                      'date' : date,
                      'food' : food,
                      'school' : school,
                      'bills' : bills,
                      'other' : other,
                      'total' : food + school + bills + other
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
            widget.mode == Mode.Editing ?
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
            child: MaterialButton(
              onPressed: () async {
                await FinProvider.deleteFin(widget.fin['id']);
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