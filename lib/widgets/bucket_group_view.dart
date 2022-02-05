import 'package:built_collection/built_collection.dart';
import 'package:fi/widgets/bucket_view.dart';
import 'package:fi/utils/colors.dart';
import 'package:fi/models/bucket_group.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/widgets/utils/root_card.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BucketGroupView extends StatelessWidget {
  final String bucketGroupId;
  final Function(String) onBucketTap;

  const BucketGroupView({
    Key? key,
    required this.bucketGroupId,
    required this.onBucketTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) {
      return storeConnector<BuiltMap<String, Item>>(
          converter: (state) => state.items,
          builder: (items) {
            final bucketGroup = items[bucketGroupId] as BucketGroup;

            return RootCard(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormBuilderTextField(
                      name: 'label',
                      initialValue: bucketGroup.label,
                      onChanged: (newValue) {
                        dispatch(SetItemLabelAction(bucketGroupId, newValue));
                      },
                      style: Theme.of(context).textTheme.headline5,
                      // style: TextStyle(
                      //   color: Theme.of(context).colorScheme.secondary, 
                      //   fontWeight: FontWeight.bold,
                      // ),
                      decoration:
                          const InputDecoration.collapsed(hintText: 'Label'),
                    ),
                    const SizedBox(height: 23),
                    ...bucketGroup.itemIds.map((itemId) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: BucketView(
                        bucketId: itemId,
                        onTap: () => onBucketTap(itemId),
                      )
                    )),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            dispatch(AddBucketAction(parentId: bucketGroupId));
                          },
                          child: Text('Add Item', style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                      ],
                    )
                  ]),
            );
          });
    });
  }
}
