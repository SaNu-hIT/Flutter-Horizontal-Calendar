import 'package:flutter/cupertino.dart';
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
    return HorizontalCalendar(DateTime.now(), itemController: itemController);
  }
}
