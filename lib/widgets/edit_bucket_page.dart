import 'package:fi/utils/colors.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/bucket_value.sg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

class EditBucketPage extends StatelessWidget {
  final String bucketId;

  const EditBucketPage({ 
    Key? key,
    required this.bucketId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic Function(dynamic)>(
      converter: (store) => store.dispatch,
      builder: (_, dispatch) {
        return StoreConnector<AppState, Bucket>(
          converter: (store) => store.state.items[bucketId] as Bucket,
          builder: (ctx, bucket) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: background,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => print('back button pressed'),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  // title: TextField(
                  //   decoration: const InputDecoration.collapsed(hintText: 'Label'),
                  //   controller: TextEditingController(text: bucket.label),
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20
                  //   ),
                  //   onSubmitted: (val) {
                  //     context.read<ItemsCubit>().updateLabel(bucket.id, val);
                  //   },
                  // ),
                  title: Text(bucket.label ?? 'Label'),
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Details'),
                      Tab(text: 'Transactions'),
                      Tab(text: 'Borrows')
                    ]
                  )
                ),
                body: Container(
                  padding: const EdgeInsets.all(10),
                  child: TabBarView(
                    children: [
                      _DetailsTab(bucket),
                      Text('Transactions'),
                      Text('Borrows'),
                    ],
                  ),
                )
                // floatingActionButton: const RootAddButton(),
              ),
            );
          },
        );
      }
    );
  }
}

class _DetailsTab extends StatelessWidget {
  final Bucket bucket;
  const _DetailsTab(this.bucket, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormBuilderTextField(
            name: 'label',
            decoration: const InputDecoration(labelText: 'Label'),
            initialValue: bucket.label,
            // onChanged: (v) => context.read<ItemsCubit>().updateLabel(bucket.id, v ?? ''),
          ),
          FormBuilderDropdown<BucketValueType>(
            name: 'type',
            decoration: const InputDecoration(labelText: 'Type'),
            items: BucketValueType.values
              .map((v) => DropdownMenuItem(
                value: v, 
                child: Text(
                  v.toString().split('.')[1].capitalize()
                ),
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

              // context.read<ItemsCubit>().updateValueType(bucket.id, newVal);
            },
          ),
          BucketValueEditor(bucket: bucket)
        ],
      )
    );
  }
}

class BucketValueEditor extends StatelessWidget {
  final Bucket bucket;
  const BucketValueEditor({
    required this.bucket,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        
          // context.read<ItemsCubit>().updateValueType(bucket.id, newVal);
        }
      );
    }

    if (value is TableBucketValue) {
      return const Text('Not Implemented Yet');
      // return Column(
      //   children: value.entries.map((entry) {
      //     return Row(
      //       children: [
      //         FormBuilderTextField(
      //           name: '${entry.name}-name',
      //           decoration: const InputDecoration(labelText: 'Label'),
      //         ),
      //         FormBuilderTextField(
      //           name: '${entry.name}-value',
      //           decoration: const InputDecoration(labelText: 'Value'),
      //         ),
      //       ],
      //     );
      //   }).toList()
      // );
    }


    return const Text('Dynamically calculated');
  }
}

extension StringCasingExtension on String {
  String capitalize() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
}