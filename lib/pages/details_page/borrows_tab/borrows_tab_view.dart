
import 'package:built_collection/built_collection.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/pages/bucket_selector_page.dart';
import 'package:fi/pages/details_page/borrows_tab/borrows_list.dart';
import 'package:fi/redux/borrows/borrows.actions.dart';
import 'package:fi/redux/selectors.dart';
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
  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) =>
       Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BorrowsList(bucketId: widget.bucketId),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    child: const Text('Create'),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (ctx) {
                          return _CreateBorrowModal(
                            bucketId: widget.bucketId,
                            onCreateBorrow: (fromId, amount) {
                              dispatch(AddBorrowAction(fromId, widget.bucketId, amount));
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          )

    );
  }
}

class _CreateBorrowModal extends StatefulWidget {
  final String bucketId;
  final void Function(String, double) onCreateBorrow;

  _CreateBorrowModal({
    Key? key,
    required this.bucketId,
    required this.onCreateBorrow,
  }) : super(key: key);

  @override
  __CreateBorrowModalState createState() => __CreateBorrowModalState();
}

class __CreateBorrowModalState extends State<_CreateBorrowModal> {
  String? _selectedBucketId;
  final _borrowAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return storeConnector<BuiltMap<String, Item>>(
      converter: (state) => state.items,
      builder: (items) {
        return storeConnector<double>(
          converter: (state) => bucketAmountSelector(state, widget.bucketId),
          builder: (bucketAmount) {
            return storeConnector<double>(
              converter: (state) => bucketTransactionsSum(state, widget.bucketId),
              builder: (transactionSum) {
                return Container(
                  padding: const EdgeInsets.all(15),
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
                          OutlinedButton(
                            onPressed: () {
                              _borrowAmountController.text = (transactionSum - bucketAmount).toStringAsFixed(2);
                            },
                            child: const Text('Difference'),
                          )
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {
                          widget.onCreateBorrow(
                            _selectedBucketId!, 
                            double.parse(_borrowAmountController.text),
                          );
                          Navigator.pop(context);
                          // _borrowAmountController.text = '';
                          // setState(() => _selectedBucketId = null);
                        },
                        child: const Text('Borrow')
                      )
                    ],
                  ),
                );
              }
            );
          }
        );
      }
    );
  }
}