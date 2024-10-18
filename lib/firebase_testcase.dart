import 'package:flutter/material.dart';

class TestCase extends StatefulWidget {
  const TestCase({super.key});

  @override
  State<TestCase> createState() => _TestCaseState();
}

class _TestCaseState extends State<TestCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'untuk ngetes masukin data, permission, dsb. dsb.'
          ),
          SizedBox(
            height: 4.0,
          ),
          Row(
            
          ),
        ],
      ),
    );
  }
}