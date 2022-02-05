
import 'package:built_collection/built_collection.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/pages/bucket_selector_page.dart';
import 'package:fi/redux/borrows/borrows.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/utils/autofocus_text_field.dart';
import 'package:flutter/material.dart';

class BorrowsTab extends StatefulWidget {
  final Bucket bucket;
  final String bucketId;

  const BorrowsTab(this.bucket, this.bucketId, { Key? key }) : super(key: key);

  @override
  State<BorrowsTab> createState() => _BorrowsTabState();
}

class _BorrowsTabState extends State<BorrowsTab> {
  String? _selectedBucketId;

  final _borrowAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) =>
      storeConnector<BuiltMap<String, Item>>(
        converter: (store) => store.items,
        builder: (items) {
          return storeConnector<BuiltMap<String, Borrow>>(
            converter: (state) => state.borrows,
            builder: (borrows) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Current Borrows',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          DataTable(
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Amount',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  '',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: borrows.entries.map((entry) {
                              return DataRow(
                                cells: [
                                  DataCell(Text('\$${entry.value.amount.toStringAsFixed(2)}')),
                                  DataCell(Text('from ${items[entry.value.fromId]!.label ?? 'label'}')),

                                  DataCell(
                                    IconButton(
                                      onPressed: () => dispatch(DeleteBorrowAction(entry.key)),
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 17
                                      )
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    )
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Create Borrow',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BucketSelectorPage(
                                title: const Text('Select Bucket'),
                                onBucketSelected: (bucketId) {
                                  Navigator.pop(context);
                                  setState(() => _selectedBucketId = bucketId);
                                },
                              )),
                            );
                            },
                            child: Text(
                              _selectedBucketId == null ? 'Select Bucket' : items[_selectedBucketId]?.label ?? 'Label'
                            )
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AutoFocusTextField(
                                  controller: _borrowAmountController,
                                  decoration: const InputDecoration(
                                    labelText: 'Amount'
                                  ),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                ),
                              ),
                              OutlinedButton(onPressed: () {}, child: const Text('Difference'))
                            ],
                          ),
                          OutlinedButton(
                            onPressed: () {
                              dispatch(AddBorrowAction(_selectedBucketId!, widget.bucketId, double.parse(_borrowAmountController.value.text)));
                              
                              _borrowAmountController.text = '';
                              setState(() => _selectedBucketId = null);
                            },
                            child: const Text('Borrow')
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          );
          
        }
      ),
    );

  }
}