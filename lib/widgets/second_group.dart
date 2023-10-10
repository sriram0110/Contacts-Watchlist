import 'package:flutter/material.dart';

class SecondGroup extends StatefulWidget {
  const SecondGroup({super.key});

  @override
  State<SecondGroup> createState() => _SecondGroupState();
}

class _SecondGroupState extends State<SecondGroup> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('2'),
    );
  }
}