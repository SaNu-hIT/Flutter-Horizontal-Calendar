import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontalcalender/horizontalcalendar.dart';

void main() {
  runApp(const ExampleClass());
}

class ExampleClass extends StatelessWidget {
  const ExampleClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        child: HorizontalCalendar(DateTime.now(),
            width: MediaQuery.of(context).size.width*.25,
            height: 120,
            selectionColor: Colors.red,
            itemController: itemController));
  }
}

