
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/bucket_value.sg.dart';
import 'package:fi/pages/details_page/bucket_value_editor/static_bucket_value_editor.dart';
import 'package:fi/pages/details_page/bucket_value_editor/table_bucket_value_editor.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/utils/utils.dart';
import 'package:fi/widgets/utils/autofocus_text_field.dart';
import 'package:flutter/material.dart';

class DetailsTab extends StatelessWidget {
  final Bucket bucket;
  final String bucketId;

  const DetailsTab(this.bucket, this.bucketId, { Key? key }) : super(key: key);

  static const _inputPadding = 15.0;

  @override
  Widget build(BuildContext context) {
    final dispatch = useDispatch(context);

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: DetailsTab._inputPadding),
          AutoFocusTextField(
            initialValue: bucket.label ?? '',
            decoration: const InputDecoration(
              labelText: 'Label',
            ),
            onChanged: (newLabel) => dispatch(SetItemLabelAction(bucketId, newLabel))
          ),
          const SizedBox(height: DetailsTab._inputPadding),
          DropdownButtonFormField(
            value: bucket.value.type,
            decoration: const InputDecoration(
              labelText: 'Type',
            ),
            items: BucketValueType.values
              .map((v) => DropdownMenuItem(
                value: v, 
                child: Text(v.toString().split('.')[1].capitalize()),
              ))
              .toList(),
            onChanged: (val) {
              BucketValue newVal;

              switch (val) {
                case BucketValueType.static:
                  newVal = StaticBucketValue();
                  break;
                case BucketValueType.table:
                  newVal = TableBucketValue();
                  break;
                case BucketValueType.extra:
                  newVal = ExtraBucketValue();
                  break;
                default:
                  throw Exception('Unkown bucket value type $val');
              }

              dispatch(SetBucketValueAction(bucketId, newVal));
            },
          ),
          const SizedBox(height: DetailsTab._inputPadding),

          if (bucket.value is StaticBucketValue) StaticBucketValueEditor(
            bucketValue: bucket.value as StaticBucketValue,
            bucketId: bucketId,
          ),
          

          if (bucket.value is TableBucketValue) TableBucketValueEditor(
            bucketValue: bucket.value as TableBucketValue,
            bucketId: bucketId,
          ),

          if (bucket.value is ExtraBucketValue) const Text('Value Dynamically Calculated')
    

        ],
      )
    );
  }
}