import 'package:fi/models/bucket_value.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/utils/autofocus_text_field.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StaticBucketValueEditor extends StatelessWidget {
  final StaticBucketValue bucketValue;
  final String bucketId;

  const StaticBucketValueEditor({ 
    Key? key,
    required this.bucketId,
    required this.bucketValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dispatch = useDispatch(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            ToggleSwitch(
              initialLabelIndex: bucketValue.isIncome ? 0 : 1,
              totalSwitches: 2,
              minWidth: 160,
              labels: const ['Income', 'Expense'],
              activeBgColors: const [[Colors.green], [Colors.redAccent]],
              onToggle: (index) {
                final newValue = bucketValue.rebuild((b) => b
                  ..isIncome = index == 0
                );
                dispatch(SetBucketValueAction(bucketId, newValue));
              },
            ),
            AutoFocusTextField(
              initialValue: bucketValue.amount.toString(),
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              onChanged: (inputVal) {
                final newValue = bucketValue.rebuild((b) => b
                  ..amount = double.tryParse(inputVal) ?? 0
                );
                dispatch(SetBucketValueAction(bucketId, newValue));
              }
            ),
          ],
        ),
      ),
    );
  }
}