import 'package:flutter/material.dart';
class _PendingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Cancel Order"))),
          const SizedBox(width: 12),
          Expanded(child: ElevatedButton(onPressed: () {}, child: const Text("Update Status"))),
        ],
      ),
    );
  }
}

class _CompletedButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Delete Order"))),
          const SizedBox(width: 12),
          Expanded(child: ElevatedButton(onPressed: () {}, child: const Text("View Invoice"))),
        ],
      ),
    );
  }
}
