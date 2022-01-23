import 'package:fi/pages/details_page/details_tab.dart';
import 'package:fi/pages/details_page/transactions_tab.dart';
import 'package:fi/utils/colors.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/bucket.sg.dart';
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
    return StoreConnector<AppState, Bucket>(
      converter: (store) => store.state.items[bucketId] as Bucket,
      builder: (ctx, bucket) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: background,
            appBar: AppBar(
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
                  DetailsTab(bucket, bucketId),
                  TransactionsTab(bucket, bucketId),
                  const Text('Borrows'),
                ],
              ),
            )
            // floatingActionButton: const RootAddButton(),
          ),
        );
      },
    );    
  }
}
