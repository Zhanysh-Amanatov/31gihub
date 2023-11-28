/*External dependencies*/
import 'package:flutter/material.dart';

class InputLabelWidget extends StatelessWidget {
  final String inputLabel;

  const InputLabelWidget({
    super.key,
    required this.inputLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              inputLabel,
              style: const TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}
