import 'package:flutter/material.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';

class KSelect<T, H> extends StatelessWidget {
  final Map<T, H> items;
  final T? value;
  final void Function(T?)? onChange;
  const KSelect({required this.items, this.onChange, this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      decoration: const InputDecoration(
        contentPadding: sXPadding,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      value: value,
      onChanged: onChange,
      items: items.entries
          .map(
            (entry) => DropdownMenuItem(
              value: entry.key,
              child: Text(entry.value.toString()),
            ),
          )
          .toList(),
    );
  }
}
