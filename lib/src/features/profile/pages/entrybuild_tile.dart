import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/features/profile/model/entry_model.dart';

class EntryItem extends StatelessWidget {
  EntryModel? entry;
  EntryItem({super.key, this.entry});
  Widget _buildTile(EntryModel root) {
    if (root.children == null || root.children!.isEmpty) {
      return ListTile(
        title: Text(root.title ?? ""),
      );
    }
    return ExpansionTile(
      title: Text(root.title!),
      key: PageStorageKey<EntryModel>(root),
      children: root.children!.map(_buildTile).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTile(entry!);
  }
}
