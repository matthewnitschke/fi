import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MonthSelector extends StatefulWidget {
  const MonthSelector({ Key? key }) : super(key: key);

  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  var _selected = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final current = DateTime(DateTime.now().year, _selected);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(DateFormat.MMMM().format(current)),
            ),
            // Text(
            //   DateFormat.y().format(current),
            //   style: const TextStyle(fontSize: 15)
            // ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                setState(() {
                  _selected--;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                setState(() {
                  _selected++;
                });
              },
            ),
          ],
        )
      ]
    );
  }
}