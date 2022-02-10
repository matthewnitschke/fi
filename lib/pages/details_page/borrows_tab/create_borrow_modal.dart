import 'package:fi/pages/bucket_selector_page.dart';
import 'package:fi/redux/selectors.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/utils/autofocus_text_field.dart';
import 'package:flutter/material.dart';

class CreateBorrowModal extends StatefulWidget {
  final String bucketId;
  final void Function(String, double) onCreateBorrow;

  const CreateBorrowModal({
    Key? key,
    required this.bucketId,
    required this.onCreateBorrow,
  }) : super(key: key);

  @override
  _CreateBorrowModalState createState() => _CreateBorrowModalState();
}

class _CreateBorrowModalState extends State<CreateBorrowModal> {
  String? _selectedBucketId;
  final _borrowAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final items = useSelector(context, (state) => state.items);
    final bucketAmount = useSelector(context, (state) => bucketAmountSelector(state, widget.bucketId));
    final transactionSum = useSelector(context, (state) => bucketTransactionsSum(state, widget.bucketId));

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
}