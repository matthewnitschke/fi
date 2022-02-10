import 'package:fi/models/bucket.sg.dart';
import 'package:fi/pages/details_page/borrows_tab/borrows_list.dart';
import 'package:fi/pages/details_page/borrows_tab/create_borrow_modal.dart';
import 'package:fi/redux/borrows/borrows.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:flutter/material.dart';

class BorrowsTab extends StatefulWidget {
  final Bucket bucket;
  final String bucketId;

  const BorrowsTab(
    this.bucket, 
    this.bucketId, { 
    Key? key,
  }) : super(key: key);

  @override
  State<BorrowsTab> createState() => _BorrowsTabState();
}

class _BorrowsTabState extends State<BorrowsTab> {
  @override
  Widget build(BuildContext context) {
    final dispatch = useDispatch(context);

    return Column(
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
                    return CreateBorrowModal(
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
    );
  }
}

