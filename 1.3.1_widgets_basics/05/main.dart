import 'package:flutter/widgets.dart';

class DummyWidget extends StatelessWidget {
  final String text;

  const DummyWidget({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
