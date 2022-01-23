import 'package:built_collection/built_collection.dart';

extension StringCasingExtension on String {
  String capitalize() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
}

extension ListBuilderExtensions<T> on ListBuilder<T> {
  void reorder(int index, int delta) {
    var newIndex = index + delta;
    if (newIndex < 0) {
      newIndex = 0;
    } else if (newIndex >= length - 1) {
      newIndex = length - 1;
    }

    final item = removeAt(index);
    insert(newIndex, item);
  }
}

extension IterableExtensions<T> on Iterable<T> {
  ListBuilder<T> toListBuilder() {
    return toBuiltList().toBuilder();
  }
}