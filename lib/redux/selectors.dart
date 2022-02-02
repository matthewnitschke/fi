
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/bucket_value.sg.dart';


double bucketAmountSelector(AppState state, String bucketId) {
  if (state.items.containsKey(bucketId) && state.items[bucketId] is! Bucket) {
    throw Exception("itemId: $bucketId is not a Bucket type, cannot calculate amount");
  }

  final bucketValue = (state.items[bucketId] as Bucket).value;

  double calculatedValue;
  if (bucketValue is StaticBucketValue) {
    calculatedValue = bucketValue.amount;
  } else if (bucketValue is TableBucketValue) {
    calculatedValue = bucketValue.entries.fold<double>(0.0, (acc, entry) => acc + entry.amount);
  } else if (bucketValue is ExtraBucketValue) {
    
    final income = state.items.values
      .whereType<Bucket>()
      .map((bucket) => bucket.value)
      .whereType<StaticBucketValue>()
      .where((bucketVal) => bucketVal.isIncome)
      .fold<double>(0.0, (acc, val) => acc + val.amount);

    final expense = state.items.entries
      .where((entry) => entry.value is Bucket)
      .where((entry) { 
        final bucketVal = (entry.value as Bucket).value;
        if (bucketVal is ExtraBucketValue) return false;
        if (bucketVal is StaticBucketValue && bucketVal.isIncome) return false;
        return true;
      })
      .fold<double>(0.0, (acc, entry) => acc + bucketAmountSelector(state, entry.key));

    calculatedValue = income - expense;
  } else {
    throw Exception('Unknown bucket value type ${bucketValue.runtimeType}');
  }

  calculatedValue += state.borrows.values.fold<double>(0.0, (acc, borrow) {
    if (borrow.toId == bucketId) {
      acc += borrow.amount;
    } else if (borrow.fromId == bucketId) {
      acc -= borrow.amount;
    }

    return acc;
  });

  return calculatedValue;
}

double bucketTransactionsSum(AppState state, String itemId) {
  final bucket = (state.items[itemId] as Bucket);

  final transactionsSum = bucket.transactions.fold<double>(
    0.0, 
    (acc, transactionId) => acc + state.transactions[transactionId]!.amount,
  ).abs();

  return transactionsSum;
}

List<String> unallocatedTransactionsSelector(AppState state) {
  final allocatedTransactions = state.items.values
    .whereType<Bucket>()
    .map((bucket) => bucket.transactions)
    .expand((transactions) => transactions)
    .toSet();


  return state.transactions.keys.toSet()
    .difference(allocatedTransactions)
    .difference(state.ignoredTransactions.toSet())
    .toList();
}

// List<Bucket> bucketTypeSelector<T extends BucketValue>(AppState state) {
//   return state.items.values
//     .where((item) => item is Bucket && item.value is T)
//     .toList();
// } 

