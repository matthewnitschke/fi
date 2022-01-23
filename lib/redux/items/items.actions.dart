
import 'package:fi/models/bucket_value.sg.dart';
import 'package:fi/utils/utils.dart';

class AddBucketGroupAction {
  final String itemId;
  final String? label;

  AddBucketGroupAction({
    String? itemId,
    this.label,
  }) :
    itemId = itemId ?? newUuid();
}

class AddBucketAction {
  final String itemId;
  final String? label;
  final String? parentId;

  AddBucketAction({
    String? itemId,
    this.label,
    this.parentId
  }) : 
    itemId = itemId ?? newUuid();
}

class DeleteItemAction {
  final String itemId;

  DeleteItemAction(this.itemId);
}

class SetItemLabelAction {
  final String itemId;
  final String? label;

  SetItemLabelAction(this.itemId, this.label);
}

class SetBucketValueAction {
  final String itemId;
  final BucketValue value;

  SetBucketValueAction(this.itemId, this.value);
}

class AllocateTransactionAction {
  final String itemId;
  final String transactionId;

  AllocateTransactionAction(this.itemId, this.transactionId);
}

class UnallocateTransactionAction {
  final String transactionId;
  UnallocateTransactionAction(this.transactionId);
}

class ReorderItemAction {
  final String itemId;

  // 1 for down, -1 for up
  final int delta;

  ReorderItemAction(this.itemId, this.delta);
}