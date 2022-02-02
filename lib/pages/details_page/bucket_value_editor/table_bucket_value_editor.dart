import 'package:built_collection/src/list.dart';
import 'package:fi/models/bucket_value.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/utils/autofocus_text_field.dart';
import 'package:flutter/material.dart';

class TableBucketValueEditor  extends StatelessWidget {
  final TableBucketValue bucketValue;
  final String bucketId;

  const TableBucketValueEditor ({ 
    Key? key,
    required this.bucketId,
    required this.bucketValue,
  }) : super(key: key);

    @override
  Widget build(BuildContext context) {

    return dispatchConnector((dispatch) =>
      Card(
          margin: const EdgeInsets.only(top: 10),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Entries', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ...bucketValue.entries.map((entry) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: AutoFocusTextField(
                          decoration: const InputDecoration(labelText: 'Label'),
                          initialValue: entry.label,
                          onChanged: (inputVal) {
                            final newVal = bucketValue.rebuild((b) => b
                              ..entries = bucketValue.entries.map((e) {
                                if (e == entry) {
                                  return e.rebuild((eb) => eb
                                    ..label = inputVal
                                  );
                                }
                                return e;
                              }).toBuiltList().toBuilder()
                            );
                            dispatch(SetBucketValueAction(bucketId, newVal));
                          }
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AutoFocusTextField(
                          decoration: const InputDecoration(labelText: 'Amount'),
                          keyboardType: TextInputType.number,
                          initialValue: entry.amount.toStringAsFixed(2),
                          onChanged: (inputVal) {
                            final newVal = bucketValue.rebuild((b) => b
                              ..entries = bucketValue.entries.map((e) {
                                if (e == entry) {
                                  return e.rebuild((eb) => eb
                                    ..amount = double.parse(
                                      inputVal.isNotEmpty == true ? inputVal : '0'
                                    )
                                  );
                                }
                                return e;
                              }).toBuiltList().toBuilder()
                            );
                            dispatch(SetBucketValueAction(bucketId, newVal));
                          }
                        ),
                      ),
                    ],
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: OutlinedButton(
                    onPressed: () {
                      final newVal = bucketValue.rebuild((b) => b
                        ..entries.add(TableBucketValueEntry())
                      );
        
                      dispatch(SetBucketValueAction(bucketId, newVal));
                    },
                    child: const Text('Add')
                  ),
                )
              ]
            ),
          ),
        )
    );
  }
}