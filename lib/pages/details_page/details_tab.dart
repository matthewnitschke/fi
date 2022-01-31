
import 'package:built_collection/src/list.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/bucket_value.sg.dart';
import 'package:fi/pages/main_page.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/edit_bucket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DetailsTab extends StatelessWidget {
  final Bucket bucket;
  final String bucketId;

  const DetailsTab(this.bucket, this.bucketId, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) {
      return FormBuilder(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormBuilderTextField(
              name: 'label',
              decoration: const InputDecoration(labelText: 'Label'),
              initialValue: bucket.label,
              onChanged: (newLabel) => dispatch(SetItemLabelAction(bucketId, newLabel))
            ),
            FormBuilderDropdown<BucketValueType>(
              name: 'type',
              decoration: const InputDecoration(labelText: 'Type'),
              items: BucketValueType.values
                .map((v) => DropdownMenuItem(
                  value: v, 
                  child: Text(v.toString().split('.')[1].capitalize()),
                ))
              .toList(),
              initialValue: bucket.value.type,
              onChanged: (val) {
                BucketValue newVal;

                switch (val) {
                  case BucketValueType.static:
                    newVal = StaticBucketValue();
                    break;
                  case BucketValueType.income:
                    newVal = IncomeBucketValue();
                    break;
                  case BucketValueType.table:
                    newVal = TableBucketValue();
                    break;
                  case BucketValueType.extra:
                    newVal = ExtraBucketValue();
                    break;
                  default:
                    throw Exception('Unkown bucket value type $val');
                }

                dispatch(SetBucketValueAction(bucketId, newVal));
              },
            ),
            BucketValueEditor(bucket, bucketId),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: OutlinedButton(
                onPressed: () {
                  dispatch(DeleteItemAction(bucketId));
                },
                child: const Text('Delete')
              )
            )
          ],
        )
      );
    });

  }
}

class BucketValueEditor extends StatelessWidget {
  final Bucket bucket;
  final String bucketId;
  const BucketValueEditor(
    this.bucket,
    this.bucketId, {
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) {
      final value = bucket.value;
      if (value is StaticBucketValue || value is IncomeBucketValue) {
        final amt = value is StaticBucketValue ? value.amount : (value as IncomeBucketValue).amount;
        return FormBuilderTextField(
          name: 'amount',
          decoration: const InputDecoration(labelText: 'Amount'),
          keyboardType: TextInputType.number,
          initialValue: amt.toString(),
          onChanged: (inputVal) {
            final amt = double.tryParse(inputVal ?? '') ?? 0;

            BucketValue? newVal;
            if (value is StaticBucketValue) {
              newVal = value.rebuild((b) => b..amount = amt);
            } else if (value is IncomeBucketValue) {
              newVal = value.rebuild((b) => b..amount = amt);
            } else {
              throw Exception('Value is not static or income');
            }

            dispatch(SetBucketValueAction(bucketId, newVal));
          }
        );
      }

      if (value is TableBucketValue) {
        return Card(
          margin: const EdgeInsets.only(top: 10),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text('Table Entries', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ...value.entries.map((entry) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: FormBuilderTextField(
                          name: '${entry.label}-name',
                          decoration: const InputDecoration(labelText: 'Label'),
                          initialValue: entry.label,
                          onChanged: (inputVal) {
                            final newVal = value.rebuild((b) => b
                              ..entries = value.entries.map((e) {
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
                        child: FormBuilderTextField(
                          name: '${entry.label}-amount',
                          decoration: const InputDecoration(labelText: 'Amount'),
                          keyboardType: TextInputType.number,
                          initialValue: entry.amount.toStringAsFixed(2),
                          onChanged: (inputVal) {
                            final newVal = value.rebuild((b) => b
                              ..entries = value.entries.map((e) {
                                if (e == entry) {
                                  return e.rebuild((eb) => eb
                                    ..amount = double.parse(
                                      inputVal?.isNotEmpty == true ? inputVal! : '0'
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
                      final newVal = value.rebuild((b) => b
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
        );
      }


      return const Text('Dynamically calculated');
    });
  }
}