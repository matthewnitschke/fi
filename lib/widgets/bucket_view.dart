import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/pages/details_page/details_page.dart';
import 'package:fi/redux/selectors.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/utils/root_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BucketView extends StatelessWidget {

  final String bucketId;

  final bool wrapWithCard;

  const BucketView({ 
    Key? key, 
    required this.bucketId,
    this.wrapWithCard = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Bucket>(
      converter: (store) => store.state.items[bucketId] as Bucket,
      builder: (ctx, bucket) {
        if (wrapWithCard) {
          return RootCard(
            onTap: _handleTap(context),
            child: _buildBucketContent(bucket),
          );
        }

        return InkWell(
          onTap: _handleTap(context),
          child: _buildBucketContent(bucket)
        );
      }
    );
  }

  Widget _buildBucketContent(Bucket bucket) {
    return storeConnector<double>(
      converter: (state) => bucketAmountSelector(state, bucketId), 
      builder: (bucketValue) {
        return storeConnector<double>(
          converter: (state) => bucketTransactionsSum(state, bucketId),
          builder: (transactionsSum) {
            final bucketFilledBy = transactionsSum == 0 || bucketValue == 0 ? 0 : (transactionsSum / bucketValue);

            return Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bucket.label ?? 'Label',
                    style: bucket.label == null ? const TextStyle(color: Colors.grey) : null,
                  ),
                  Text('\$${bucketValue.toStringAsFixed(0)}')
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: LinearProgressIndicator(
                  value: bucketFilledBy.toDouble(),
                  color: bucketFilledBy > 1 ? const Color.fromARGB(255, 255, 0, 0) : const Color(0xFF62ce66),
                  backgroundColor: const Color.fromARGB(255, 221, 221, 221),
                ),
              )
            ]);
          }
        );
      },
    );
  }

  void Function() _handleTap(BuildContext context) => () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(bucketId: bucketId,)),
    );
  };
}