import 'package:fi/pages/details_page/borrows_tab/borrows_tab_view.dart';
import 'package:fi/pages/details_page/details_tab.dart';
import 'package:fi/pages/details_page/transactions_tab.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DetailsPage extends StatelessWidget {

  final String bucketId;

  const DetailsPage({ 
    Key? key,
    required this.bucketId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bucket = useSelector(context, (state) => state.items[bucketId] as Bucket);
    final dispatch = useDispatch(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(bucket.label ?? 'Label'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Transactions'),
              Tab(text: 'Borrows')
            ]
          ),
          actions: [
            IconButton(
              onPressed: () {
                dispatch(DeleteItemAction(bucketId));
                Navigator.pop(context);
              }, 
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              DetailsTab(bucket, bucketId),
              TransactionsTab(bucket, bucketId),
              BorrowsTab(bucket, bucketId),
            ],
          ),
        )
        // floatingActionButton: const RootAddButton(),
      ),
    );
  }
}
